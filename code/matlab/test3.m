k=8;
max_seed = 100;
[est_N, stderr_N, est_PGS, stderr_PGS] = Oct13_Collect('BIZ','SC',k,max_seed);
est_Nk = est_N / k;
stderr_Nk = stderr_N / k;
% this shouuld match the C++ results for SC under BIZUNK,
% k=8 PCS=0.893+/-0.003 E[N]/k=362.183+/-1.513 E[stages]=160.864+/-1.302
PGS_correct = 0.893;
Nk_correct = 362;
PGS_z = abs((est_PGS - PGS_correct)/stderr_PGS);
Nk_z = abs((est_Nk - Nk_correct)/stderr_Nk);
if (PGS_z > 3 || Nk_z > 3)
  disp('test failed');
else
  disp('test OK');
end
