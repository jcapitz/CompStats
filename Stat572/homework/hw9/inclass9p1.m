% PART 0. 
% generate hypothezied rs from bernoulli(0.2)
data = binornd(1,0.2,1,100); m = length(data);

% PART 1. 
% use the M-H sampler to generate MC of size 2000 whose invariance
% (target) distribution is given by the posterior distribution of
% theta|X

% Set up function handle to evaluate the likelihood.
likelihood = @(theta,x,n) theta.^sum(x).*(1-theta).^(n-sum(x));

% Generate 10000 samples in the chain.
n = 20000; % random sample size
% initialize the chain
mc1 = zeros(1,n);
mc1(1) = rand(1); % generate the starting point
for i = 2:n
    % generate a candidate from the chosen prior unif(0,1)
    y = unifrnd(0,1);
    % generate a uniform for comparison
    u = rand(1);
    alphaf = min([1, likelihood(y,data,m)/(likelihood(mc1(i-1),data,m))]);
    if u <= alphaf
        mc1(i) = y;
    else
        mc1(i) = mc1(i-1);
    end
end
% burn-in 5%
mc1= mc1(0.05*n+1:n);

% PART 2.
% Given that we know the posterior theta|x is dist Beta(sum(x)+1,n-sum(x)+1
% generate a MC from this dist using the random walk sampler.

% Set up function handle to evaluate the Beta kernel.
betapdfker = @(x,a,b) (x.^(a-1)).*((1-x).^(b-1));
alpha = sum(data)+1; beta = m-sum(data)+1; % parameters for the beata

% generate the MC
mc2 = zeros(1,n);
mc2(1) = rand(1); % generate the starting point
for i = 2:n
    % generate a candidate from the chosen prior unif(0,1)
    a = -0.5; b = 0.5;
    z = a + (b-a)*unifrnd(0,1);
    y = mc2(i-1)+z/sqrt(12);
    % generate a uniform for comparison
    u = rand(1);
    alphaf = min([1, betapdfker(y,alpha,beta)/(betapdfker(mc2(i-1),alpha,beta))]);
    if u <= alphaf
        mc2(i) = y;
    else
        mc2(i) = mc2(i-1);
    end
end
% burn-in 5%
mc2= mc2(0.05*n+1:n);

% Part 3.
% Calculate mean and sd
meanMC1 = mean(mc1);
stdMC1 = std(mc1);
meanMC2 = mean(mc2);
stdMC2 = std(mc2);
fprintf('\nThe mean of the Bayesian MC is: %2.4f\n',meanMC1)
fprintf('\nThe std deviation of the Bayesian MC is: %2.4f\n',stdMC1)
fprintf('\nThe mean of the Random Walk MC is: %2.4f\n',meanMC2)
fprintf('\nThe std deviation of the Random Walk MC is: %2.4f\n',stdMC2)

% Part 4.
% plot histograms and compare
figure(1)
subplot(1,2,1)
[fhath, bc] = hist(mc1);
fhath = fhath/((bc(2)-bc(1))*sum(fhath));
bar(bc,fhath,1,'b')
title('Bayesian MCMC')
subplot(1,2,2)
[fhath, bc] = hist(mc2);
fhath = fhath/((bc(2)-bc(1))*sum(fhath));
bar(bc,fhath,1,'b')
title('Metropolis Random Walk')


