% Two-tailed test for Example 7.6 
clc
load mcdata
n = length(mcdata);  								
% Population sigma is known.
sigma = 7.8;					
sigxbar = sigma/sqrt(n);
% Get the observed value of the test statistic.
Tobs = (mean(mcdata)-454)/sigxbar;

% This command generates the normal probability plot.
normplot(mcdata)

M = 1000; % Number of Monte Carlo trials
	% Storage for test statistics from the MC trials.
	Tm = zeros(1,M);
	% Start the simulation.
for i = 1:M
			% Generate a random sample under H_0
			% where n is the sample size.
			xs = sigma*randn(1,n) + 454;
			Tm(i) = (mean(xs) - 454)/sigxbar;
end

% Get the critical value for alpha.
% This is a two-tail test, so we need the
% alpha and 1-alpha quantile.
alpha = 0.05;
cv1 = csquantiles(Tm,alpha/2);
cv2 = csquantiles(Tm,1-alpha/2);
fprintf('Critical Values\t\t%9.3f\t%9.3f\n',cv1,cv2)

% Plot
figure(2); hist(Tm)
set(get(gca,'child'),'FaceColor',[.9 .9 .9],'EdgeColor','black');
hold on
plot(cv1,0,'*',cv2,0,'*')
legend('frequency','lower tail critical value','upper tail critical value',2)
hold off