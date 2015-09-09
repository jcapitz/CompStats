% Code for exercise 7.7

% get the dataset
load forearm;
% PART A
n = length(forearm); % sample size
B = 10000;	% number of bootstrap replicates
% Get the value of the statistic of interest.
theta1 = skewness(forearm);
theta2 = kurtosis(forearm);
theta3 = var(forearm,1);

% Use unidrnd to get the indices to the resamples.
inds = unidrnd(n,n,B);
% Extract these from the data.
foreboot = forearm(inds);
theta1b = skewness(foreboot); % get the skewnwness for each column using
theta2b = kurtosis(foreboot); % get the kurtosis for each column using
theta3b = var(foreboot,1); % get the 2nd moment for each column using

seb1 = std(theta1b);
seb2 = std(theta2b);
biasEst1 = mean(theta1b)-theta1;
biasEst2 = mean(theta2b)-theta2;

% PART B
% find the bootstrap percentile interval for the central 2nd moment
alpha = 0.1;
k = B*alpha/2;
theta3b = sort(theta3b);
blo = theta3b(k);
bhi = theta3b(B-k);

fprintf('Skewness Standard Error and Bias %9.3f\t%4.3f\n\n',seb1,biasEst1)
fprintf('Kurtosis Standard Error and Bias %9.3f\t%4.3f\n\n',seb2,biasEst2)
fprintf('Pct Interval for 2nd Central Moment (%2.3f, %3.3f)\n',blo,bhi)


% figure(1)
% hist(thetab)
% set(get(gca,'child'),'FaceColor',[.9 .9 .9],'EdgeColor','black');
% title('Boostrapped Sample Mean Histogram')
% ylabel('Frequency');  xlabel('Sample mean')

% % PART B
% thetat = trimmean(X,10); % use MATLAB trimmed mean function to estimate 
% thetatb = trimmean(xboot,10); % generate boostrap trimmed mean
% sebt = std(thetatb); % calculate the boostrap standard error
% biastEst = mean(thetatb)-thetat; % estimate the bias
% 
% figure(2)
% hist(thetatb)
% set(get(gca,'child'),'FaceColor',[.9 .9 .9],'EdgeColor','black');
% title('Boostrapped Trimmed Mean Histogram')
% ylabel('Frequency'); xlabel('Trimmed mean')
% 
% par={'Sample Mean';'Trimmed Mean'}; Value = [mean(thetab); mean(thetatb)];
% StdError = [seb; sebt]; Bias = [biasEst; biastEst];
% T=table(Value,StdError,Bias,'RowNames',par); disp(T)
