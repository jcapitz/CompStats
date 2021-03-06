% Code for exercise 7.9

% get the dataset
load forearm;
% PART A
n = length(forearm); % sample size
B = 10000;	% number of bootstrap replicates
% Get the value of the statistic of interest.
thetahat = mean(forearm);

% Use unidrnd to get the indices to the resamples.
inds = unidrnd(n,n,B);
% Extract these from the data.
foreboot = forearm(inds);
thetahatb = mean(foreboot); % get the mean for each column using
seb = std(thetahatb);

% PART B
% find the bootstrap percentile interval for the central 2nd moment
% calculate the CI
alpha = 0.05;
cilo = thetahat-norminv(1-alpha/2,0,1)*seb;
cihi = thetahat-norminv(alpha/2,0,1)*seb;

% theoretical CI
tcilo = thetahat-norminv(1-alpha/2,0,1)*(std(forearm)/sqrt(n));
tcihi = thetahat-norminv(alpha/2,0,1)*(std(forearm)/sqrt(n));

fprintf('Standard Interval for the mean (%2.3f, %3.3f)\n',cilo,cihi)
fprintf('Theoretical Standard Interval for the mean (%2.3f, %3.3f)\n',tcilo,tcihi)
