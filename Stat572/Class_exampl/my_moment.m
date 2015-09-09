% Example 3.1
% Dr. Kim's example in class to illustrate creating a function

function [mu,sigma2,skew,kurt] = my_moment(x)
n=length(x);
% find the mean of the sample
mu=mean(x);
sigma2=var(x);
% find the numerator and denominator for beta3
num = (1/n)*sum((x-mu).^3);
den = (1/n)*sum((x-mu).^2);
skew = num/den^(3/2);

% find the kurtosis
num=(1/n)*sum((x-mu).^4);
den = (1/n)*sum((x-mu).^2);
kurt = num/den^2;
