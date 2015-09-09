% Take rs of size 100 from exp(5)
n = 1000;
data = exprnd(5,1,n);

% Use Normal Reference Rule for bin width
% of frequency histogram.
h = 2.15*sqrt(var(data))*n^(-1/5);
t0 = min(data)-1;
tm = max(data)+1;
bins = t0:h:tm;
vk = histc(data,bins);
vk(end) = [];
fhat = vk/(n*h);
bc = (t0+h/2):h:(tm-h/2);
bar(bc,fhat,1,'w')
hold on
xlabel('X - variable')
ylabel('Probability Density Function')
title('Kernel Density Estimation')

% Monte Carlos Trials
M = 100;
% choose an appropriate domain
x = linspace(-4,35,5000); % domain
% allocate MSE vectors
MSEn = zeros(1,M);
MSEe = zeros(1,M);
% find the index for x = x0 = 5
x0ind = find(x>4.999 & x<5.009);    

% NORMAL KERNEL

% choose smoothing parameter
h = 1.06*std(data)*n^(-1/5);

for j = 1:M
    % sample from exponential
    data = exprnd(5,1,n);
    % initialize vector for estimated pdf
    fhat = zeros(size(x));
    
    % evaluate using the normal kernel for each data point
    % at all x in the domain
    for i=1:n
        % get each kernel function evaluated at x
        % centered at data and weighted by h
        f=exp(-(1/(2*h^2))*(x-data(i)).^2)/sqrt(2*pi)/h;
        % add each ith average f vector to get estimate pdf height
        fhat = fhat+f/(n);
    end
    % take mean of MSE because sometimes the x0ind interval may contain 
    % more than one MSE
    MSEn(j) = mean((exppdf(5,5)-fhat(x0ind)).^2); % take mean bec
end
% Calculate the expected value of the MSE for x = x0, normal kernel
MSEn = mean(MSEn);
linenorm = plot(x,fhat,'--b');

% Density estimate using Epanechnikov
% adjust smoothing parameter for the Epanchnikov kernel
h = h*(30*sqrt(pi))^(1/5);

for j = 1:M
    % sample from exponential
    data = exprnd(5,1,n);
    % initialize vector for estimated pdf
    fhat = zeros(size(x));
    
    % evaluate using the Epanchnikov kernel for each data point
    % at all x in the domain
    for i=1:n
        % set up the indicator function
        I = abs((x-data(i))/h)<1;
        % get each kernel function evaluated at x
        % centered at data
        f=(0.75*(1-(((x-data(i)).^2)/(h^2)))/h).*I;
        fhat = fhat+f/(n);
    end
    MSEe(j) = mean((exppdf(5,5)-fhat(x0ind)).^2);
end
% Calculate the expected value of the MSE for x = x0, epan kernel
MSEe = mean(MSEe);

lineepan = plot(x,fhat,'Color','r');
axis([-4 35 0 .18])
legend([linenorm,lineepan],'Normal Kernel Estimate','Epanchnikov Kernel Estimate')
hold off

fprintf('\nMSE using Normal Kernel density estimation: %2.6d\n', MSEn)
fprintf('\nMSE using Epan Kernel density estimation: %2.6d\n', MSEe)