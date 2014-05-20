% Runs through all of the data collected by Oct13_RunBIZ.sh and Oct13_RunKN.sh
% on the sSCont problem for a variety of different values of k, and writes it
% out to Oct13_BIZ.csv and Oct13_KN.csv.  The format of these two files is as
% follows:
% Col 1 is k, col 2 is estimated E[N/k], col 3 is the stderr of this estimate, 
% col 4 is the estimated PGS, col 5 is the stderr of the estimate of PGS.

kvec = [2, 5, 10, 25, 50, 100, 250, 500, 1000, 2500, 5000, 10000]; % These are the different values of k for which we ran sSCont
max_seed_BIZ = 300; % This is the number of independent replications we ran
max_seed_KN = 300;
% These two matrices, BIZ and KN, store the results from our simulations.  
BIZ = zeros(length(kvec),5); 
KN  = zeros(length(kvec),5);
improvement  = zeros(length(kvec),3);
for i=1:length(kvec)
	k = kvec(i);
	BIZ(i,1)=k;
	KN(i,1)=k;
	[BIZ(i,2), BIZ(i,3), BIZ(i,4), BIZ(i,5)] = Oct13_Collect('BIZ','sSCont',k,max_seed_BIZ);
	if (k>= 2500)
		max_seed_KN=100;
	end
	[KN(i,2), KN(i,3), KN(i,4), KN(i,5)] = Oct13_Collect('KN','sSCont',k,max_seed_KN);
end

% Compute the improvement (ratio of KN samples to BIZ samples).
x =  KN(:,2);
sx = KN(:,3);
y =  BIZ(:,2)
sy = BIZ(:,3)
improvement(:,1) = kvec;
improvement(:,2) = x ./ y;
improvement(:,3) = sqrt(sx.^2 + sy.^2 .* improvement(:,1)) ./ y;
csvwrite('Oct13_BIZ.csv',BIZ);
csvwrite('Oct13_KN.csv',KN);
csvwrite('Oct13_improvement.csv',improvement);
