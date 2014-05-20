kvec = [2, 5, 10, 25, 50, 100, 250, 500, 1000, 2500, 5000, 10000]; % These are the different values of k for which we ran sSCont
load('sSCont.mat');
for k=kvec
	[good, z_scores] = DetermineGoodEnough(est_mean(1:k),stderr(1:k),delta); % only take the first k
	m = sort(-est_mean(1:k));
	disp(sprintf('k=%d ngood=%d best-second_best=%g', k, sum(good), m(2)-m(1)));
end
