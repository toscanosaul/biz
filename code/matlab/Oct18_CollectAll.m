% Runs through all of the data collected by Oct18_RunBIZ.sh and Oct18_RunKN.sh
% on the sSCont problem for a variety of different values of k, and writes it
% out to Oct18_BIZ.csv and Oct18_KN.csv.  The format of these two files is as
% follows:
% Col 1 is k, col 2 is estimated E[N/k], col 3 is the stderr of this estimate, 
% col 4 is the estimated PGS, col 5 is the stderr of the estimate of PGS.

kvec = [2, 5, 10, 25, 50, 100, 250, 500, 1000]; % These are the different values of k for which we ran sSCont
max_seed_BIZ = 100; % This is the number of independent replications we rane 
max_seed_KN = 100;
% These two matrices, BIZ and KN, store the results from our simulations.  
BIZ = zeros(length(kvec),5); 
KN  = zeros(length(kvec),5);
for i=1:length(kvec)
	k = kvec(i);
	BIZ(i,1)=k;
	KN(i,1)=k;
	[BIZ(i,2), BIZ(i,3), BIZ(i,4), BIZ(i,5)] = Oct18_Collect('BIZ','sSCont',k,max_seed_BIZ);
	[KN(i,2), KN(i,3), KN(i,4), KN(i,5)] = Oct18_Collect('KN','sSCont',k,max_seed_KN);
end
csvwrite('Oct18_BIZ.csv',BIZ);
csvwrite('Oct18_KN.csv',KN);
