function [fn, FnVar, FnGrad, FnGradCov, constraint, ConstraintCov, ConstraintGrad, ConstraintGradCov] = sSInt(x, runlength, seed, other);
% function [fn, FnVar, FnGrad, FnGradCov, constraint, ConstraintCov, ConstraintGrad, ConstraintGradCov] = sSInt(x, runlength, seed, other);
% x is a vector containing 2 components: (s,S)
% runlength is the number of hours of simulated time to simulate
% seed is the index of the substreams to use (integer >= 1)
% other is not used
% Returns Mean cost, no var or gradient estimates.
%   ****************************************
%   *** Code written by German Gutierrez ***
%   ***         gg92@cornell.edu         ***
%   ***                                  ***
%   *** Updated by Shane Henderson to    ***
%   *** use standard calling and random  ***
%   *** number streams                   ***
%   ****************************************
% Last updated August 24, 2011

FnGrad = NaN;
FnGradCov = NaN;
constraint = NaN;
ConstraintCov = NaN;
ConstraintGrad = NaN;
ConstraintGradCov = NaN;

if (sum(x < 0) > 0) || (sum(x>2500)>0) || (runlength <= 0) || (seed <= 0) || (round(seed) ~= seed),
    fprintf('x (row vector with %d components)\nx components should be between 0 and 1\nrunlength should be positive and real,\nseed should be a positive integer\n', nAmbulances*2);
    fn = NaN;
    FnVar = NaN;
else % main simulation

%%%%%%%%%%%%%%%%PARAMETERS%%%%%%%%%%%%%%%%%%
nDays = runlength;               %Length of simulation
nRepetitions = 20;          %Repetitions
fixed = 36;                 %Fixed order cost
var = 2;                    %Variable, per unit, cost
holding = 1;                % Holding cost
warmup = 50;                %length of warm up period

%%%%%%%%Decision Variables%%%%%%%%%
s= x(1); % 1000;
S= x(2); % 2000;

Output = zeros(2,nRepetitions);
Inv = zeros(nRepetitions, nDays);

% Generate new streams for demand and lead-time 
[DemandStream, LTStream] = RandStream.create('mrg32k3a', 'NumStreams', 2);

% Set the substream to the "seed"
DemandStream.Substream = seed;
LTStream.Substream = seed;

% Generate random data
OldStream = RandStream.setGlobalStream(DemandStream); % Temporarily store old stream

%Generate matrix of demands.
Dem = exprnd(100, nRepetitions, nDays);

% Generate lead times
RandStream.setGlobalStream(LTStream);
LT = poissrnd(10, nRepetitions, nDays);

% Restore old random number stream
RandStream.setGlobalStream(OldStream);

for j =1:nRepetitions

    %Vector tracks outstanding orders. Row 1: day of delivery and row 2: quantity.
    Orders = zeros(2,1);
    InvOH = 1500;
    %Variables to estimate service level constraint.
    nUnits = 0;
    nLate = 0;
    lates = zeros(nDays,1);

    TotalCost = 0;
    
    for i=1:nDays
        Inv(j,i) = InvOH; 
        
        %Receive orders
        if length(Orders(1,:)) > 1
            [C,I] = min(Orders(1,2:length(Orders(1,:))));
            while( C == i)
                InvOH = InvOH + Orders(2,I+1);
                Orders(:,I+1) = [];
                C = 0;
                I = 0;
                if length(Orders(1,:)) > 1
                    [C,I] = min(Orders(1,2:length(Orders(1,:))));
                end
            end
        end
        

        %Satisfy or backorder demand
        Demand = Dem(j,i);
        InvOH = InvOH - Demand;
        if(i > warmup)
            nUnits = nUnits + Demand;
            if InvOH < 0
                nLate = nLate + min(Demand, -InvOH);
            end
        end
        
        
        %Calculate Inventory Position and place orders.
        IP = InvOH + sum(Orders(2,:));
        if( IP < s )
            leadTime = LT(j,i);
            x = S-IP;
            Orders = [Orders [i+leadTime+1; x]];
            if ( i > warmup)
                TotalCost= TotalCost + fixed + x*var;
            end
        end
        
        if ( i > warmup)
            TotalCost = TotalCost + holding*max(InvOH, 0);
        end           
    end

Output(1,j) = TotalCost/(nDays-warmup);
Output(2,j) = nLate/nUnits;

end
%First row has mean cost, second has stockout rate:
fn = mean(Output,2);
%CIHalfWidth = 1.96 * (std(Output')/sqrt(nRepetitions))'
end
