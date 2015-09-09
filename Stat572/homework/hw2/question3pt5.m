%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 3.5: Generate normal random samples of size n            %
% and analyze skewness, and kurtosis.                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = [2000,15000,45000];
size = {'n = 2000 ';'n = 15000';'n = 45000'};
Skewness = zeros(3,1);
Kurtosis = zeros(3,1);

for i = 1:length(n)
    % generate a random sample from the uniform dist
    x = randn(1,n(i));
    % find the mean of the sample
    mu=mean(x);
    
    % find the skewness
    num = (1/n(i))*sum((x-mu).^3);
    den = (1/n(i))*sum((x-mu).^2);
    Skewness(i) = num/den^(3/2);
    
    % find the kurtosis
    num=(1/n(i))*sum((x-mu).^4);
    den = (1/n(i))*sum((x-mu).^2);
    Kurtosis(i) = num/den^2;
end
 
Table = table(Skewness,Kurtosis,'RowNames',size);
disp(Table)