% Code for exercise 7.8

% get the dataset
load forearm;
% PART A
n = length(forearm); % sample size
B = 10000;	% number of bootstrap replicates
% Get the value of the statistic of interest.
thetahat = var(forearm,1);

% Use unidrnd to get the indices to the resamples.
inds = unidrnd(n,n,B);
% Extract these from the data.
foreboot = forearm(inds);
thetahatb = var(foreboot,1); % get the 2nd moment for each column using
seb = std(thetahatb);

% PART B
% find the bootstrap percentile interval for the central 2nd moment
% calculate the CI
alpha = 0.05;
cilo = thetahat-norminv(1-alpha/2,0,1)*seb;
cihi = thetahat-norminv(alpha/2,0,1)*seb;

fprintf('Standard Interval for 2nd Central Moment (%2.3f, %3.3f)\n',cilo,cihi)