addpath ~/Documents/Stat572/CompStatsToolboxV2;
load geyser
data = geyser; n = length(data);

% choose an appropriate domain
x = linspace(40,110,1000); % domain

% NORMAL KERNEL

% choose smoothing parameter
h = 1.06*std(data)*n^(-1/5);

% initialize vector for estimated pdf
fhat = zeros(size(x));

% evaluate using the normal kernel for each data point
% at all x in the domain
for i=1:n
    % get each kernel function evaluated at x
    % centered at data and weighted by h
    f=exp(-(1/(2*h^2))*(x-data(i)).^2)/sqrt(2*pi)/h;
    % add each ith average f vector to get estimate pdf height
    fhat = fhat+f/n;
end

% Now generate some random variables from this model.
% The model is defined as a kernel density estimation model with n
% component distributions

% The weights for each component kernel is 1/n
% thus create a vector (p1, p1+p2, p1+p2+p3...)
p = (1/n):(1/n):1;

% Set up the random sample generation procedure
k = 300; mus = zeros(1,k);

% this loop generates the means from the kernel vector from the original
% data
for i = 1:k
    u = rand;
    for j = 1:length(p)-1
        if u >= p(j) && u <= p(j+1)
            mus(i) = data(j);
        end
    end
end

% This generates the actual random sample variables
rs = randn(1,k)*h + mus;

% Plots
% Create histograms 
subplot(121);
histdata = hist(data)./n;
xhist = linspace(min(data)+1,max(data)-1,length(histdata));
bar(xhist,histdata,1,'r')
axis([38 115 0 .3]); 
xlabel('Geyser Values'); ylabel('Probability')
title('Actual Geyser Data','FontSize',14)

subplot(122);
histdata = hist(rs)./k;
xhist = linspace(min(rs)+1,max(rs)-1,length(histdata));
bar(xhist,histdata,1,'b')
axis([(min(rs)-10) (max(rs)+10) 0 (max(histdata)+.05)])
xlabel('Geyser Values'); ylabel('Probability')
title('Geyser Random Sample','FontSize',24)