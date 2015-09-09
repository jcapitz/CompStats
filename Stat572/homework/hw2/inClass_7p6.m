% In-class; hypothesis test on the standard deviation parameter

load mcdata; n = length(mcdata);  								
% Population sigma is known.
sigma = 7.8; sigxbar = sigma/sqrt(n);
% Get the observed value of the test statistic.
Tobs = (n-1)*var(mcdata)/sigma^2;

figure(1); normplot(mcdata) % This command generates the QQ plot.

M = 1000; % Number of Monte Carlo trials
Tm = zeros(1,M);
% Start the simulation.
for i = 1:M
			% Generate a rand sample under H_0 where n is the sample size.
			xs = sigma*randn(1,n) + mean(mcdata);
			Tm(i) = (n-1)*var(xs)/sigma^2;
end

% Get the critical value for alpha.
% This is a upper-tail test, so it is the 1-alpha quantile.
alpha = 0.05; cv = csquantiles(Tm,1-alpha);

% Plotting in-class
figure(2); hist(Tm)
set(get(gca,'child'),'FaceColor',[.9 .9 .9],'EdgeColor','black');
hold on
plot(cv,0,'*',Tobs,0,'bo')
legend('frequency','critical value','observed value')
hold off

% Calculating the p-value
g = [];
for i=1:length(Tm)
    if Tm(i) >= Tobs
        g = [g,Tm(i)];
    end
end
pval=length(g)/length(Tm);
