%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 3.16: investigate the bias of the MLE for the variance   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate normal random sample matrix
X = randn(5000,5000);
n = length(X);
svec = zeros(1,n);

% generate vector of sample variances
for i=1:n
    xbar = mean(X(i,:));
    ssq = sum((X(i,:)-xbar).^2)/n;
    svec(i) = ssq;
end

% calculate the expected sample variance
meanssq = mean(svec);


