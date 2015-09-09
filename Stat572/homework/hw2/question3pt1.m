%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 3.1: Generate 500 random samples of size n:              %
% and analyze the behavior of the sample mean and variance.         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = [2,15,45];
size = {'n = 2 ';'n = 15';'n = 45'};
Mean =  zeros(3,1);
Variance = zeros(3,1);

for i=1:length(n)
    x = randn(n(i),500);
    xbar = mean(x);
    Mean(i) = mean(xbar);
    Variance(i) = var(xbar);

    % plot the data
    figure(i)
    histfit(xbar)
    title(['Frequency Histogram, ' 'n=' num2str(n(i))])
end
 
Table = table(Mean,Variance,'RowNames',size);
disp(Table)