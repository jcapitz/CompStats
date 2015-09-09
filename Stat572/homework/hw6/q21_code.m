% use forearm  data
load forearm
data = forearm'; n = length(data);

% Use Normal Reference Rule for bin width
% of frequency histogram.
h = 3.5*sqrt(var(data))*n^(-1/5);
t0 = min(data)-1;
tm = max(data)+1;
bins = t0:h:tm;
vk = histc(data,bins);
vk(end) = [];
fhat = vk/(n*h);
bc = (t0+h/2):h:(tm-h/2);
bar(bc,fhat,1,'w')
hold on
xlabel('Forearm Data')
ylabel('Probability Density Function')
title('Kernel Density Estimation')

% choose an appropriate domain
x = linspace(15,25,100); % domain
% sample size of MC sampling
n = 100;

% NORMAL KERNEL

% choose smoothing parameter
h = 1.06*std(data)*n^(-1/5);

% initialize vector for estimated pdf
fhat = zeros(size(x));

% sample from forearm data
ind = unidrnd(length(forearm),1,n);
data = forearm(ind);

% evaluate using the normal kernel for each data point
% at all x in the domain
for i=1:n
    % get each kernel function evaluated at x
    % centered at data and weighted by h
    f=exp(-(1/(2*h^2))*(x-data(i)).^2)/sqrt(2*pi)/h;
    % add each ith average f vector to get estimate pdf height
    fhat = fhat+f/(n);
end

linenorm = plot(x,fhat,'--b');

% Density estimate using Epanechnikov

% adjust smoothing parameter for the Epanchnikov kernel
h = h*(30*sqrt(pi))^(1/5);

% initialize vector for estimated pdf
fhat = zeros(size(x));

% sample from forearm data
ind = unidrnd(length(forearm),1,n);
data = forearm(ind);

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

lineepan = plot(x,fhat,'Color','r');
axis([15 23 0 .45])
legend('Histogram with Normal Reference Rule','Normal Kernel Estimate','Epanchnikov Kernel Estimate')
hold off