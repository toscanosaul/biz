k=8;
max_seed = 1000;
[est_N, stderr_N, est_PGS, stderr_PGS] = Oct13_Collect('KN','SC',k,max_seed);
est_Nk = est_N / k;
stderr_Nk = stderr_N / k;
% this shouuld match the C++ results for SC under KNUNK,
% k=8 PCS=0.942+/-0.002 E[N]/k=544.573+/-1.476 E[stages]=778.235+/-2.523
PGS_correct = 0.942;
Nk_correct = 544.573;
PGS_z = abs((est_PGS - PGS_correct)/stderr_PGS);
Nk_z = abs((est_Nk - Nk_correct)/stderr_Nk);
if (PGS_z > 3 || Nk_z > 3)
  disp('test failed');
else
  disp('test OK');
end


