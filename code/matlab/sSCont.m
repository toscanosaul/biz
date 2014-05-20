%   ***************************************
%   *** Code written by German Gutierrez***
%   ***         gg92@cornell.edu        ***
%   ***************************************

%RETURNS:  Avg. and C.I. half width for per period cost and the stockout
%rate. Currently set to 1 repetitions of 1,000 days each (50 day warmup).
% PF: modifications:
%	modified # of repetitions from 20 to 1.
%	modified it to return negative cost

function [fn, FnVar, FnGrad, FnGradCov, constraint, ConstraintCov, ConstraintGrad, ConstraintGradCov] = sSCont(x, runlength, seed, other);
% function [fn, FnVar, FnGrad, FnGradCov, constraint, ConstraintCov, ConstraintGrad, ConstraintGradCov] = sSCont(x, runlength, seed, other);
% x is the (s, S) vector
% runlength is the number of days of demand to simulate
% seed is the index of the substreams to use (integer >= 1)
% other is not used

constraint = NaN;
ConstraintCov = NaN;
ConstraintGrad = NaN;
ConstraintGradCov = NaN;

if (sum(x < 0)> 0 )|| (runlength <= 0) || (runlength ~= round(runlength)) || (seed <= 0) || (round(seed) ~= seed),
    fprintf('x should be >= 0, runlength should be positive integer, seed must be a positive integer\n');
    fn = NaN;
    FnVar = NaN;
    FnGrad = NaN;
    FnGradCov = NaN;
else
%%%%%%%%%%%%%%%%PARAMETERS%%%%%%%%%%%%%%%%%%
nDays = runlength;          %Length of simulation: 10050
nRepetitions = 1;           %Repetitions
meanDemand = 100;           %Mean demand
meanLT = 6;                 %Mean lead time
fixed = 36;                 %Fixed order cost
var = 2;                    %Variable, per unit, cost
holding = 1;                % Holding cost
warmup = 50;                %length of warm up period

%%%%%%%%Decision Variables%%%%%%%%%
s=x(1);
S=x(2); %[1000 2000] starting Sol

    % Generate new streams for 
    [DemandStream, LeadTimeStream] = RandStream.create('mrg32k3a', 'NumStreams', 2);

    % Set the substream to the "seed"
    DemandStream.Substream = seed;
    LeadTimeStream.Substream = seed;

    % Generate demands
    OldStream = RandStream.setGlobalStream(DemandStream);
    Dem=exprnd(meanDemand, nRepetitions, nDays);
    
    % Generate lead times
    RandStream.setGlobalStream(LeadTimeStream);
    LT=poissrnd(meanLT, nRepetitions, nDays);
    
    RandStream.setGlobalStream(OldStream); % Restore previous stream


Output = zeros(2,nRepetitions);
Inv = zeros(nRepetitions, nDays);
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

Output(1,j) = -TotalCost/(nDays-warmup);
Output(2,j) = nLate/nUnits;

end
%First row has mean cost, second has stockout rate:
fn = mean(Output(1,:));
FnVar= std(Output(1,:).^2);

%CIHalfWidth = 1.96 * (std(Output')/sqrt(nRepetitions))'

end
end

