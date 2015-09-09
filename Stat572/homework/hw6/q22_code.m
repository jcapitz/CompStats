addpath ~/Documents/Stat572/CompStatsToolboxV2;
% use elderly  data
load elderly
data = heights; n = length(data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FREQUENCY POLYGON %
% Use Normal Reference Rule for bin width
% of frequency polygon.
h = 0.5*2.15*sqrt(var(data))*n^(-1/5);
t0 = min(data)-1;
tm = max(data)+1;
bins = t0:h:tm;
vk = histc(data,bins);
vk(end) = [];
fhatfreq = vk/(n*h);

% For freq polygon, get the bin centers, with empty
% bin center on each end.
bc2=(t0-h/2):h:(tm+h/2);
binh = [0 fhatfreq 0];
% Use linear interpolation between bin centers
% get the interpolated values at x.
xinterp = linspace(min(bc2),max(bc2));
fp = interp1(bc2, binh, xinterp);
% to plot this, use bar with the bin centers
tm = max(bins);
bc = (t0+h/2):h:(tm-h/2);

figure(1)
bar(bc,fhatfreq,1,'w')
hold on
plot(xinterp,fp)
hold off
xlabel('Heights')
ylabel('Probability Density')
title('Frequency Polygon Density Estimation')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPAN KERNERL %

% Use Normal Reference Rule for bin width
% of frequency histogram.
h = 0.5*2.15*sqrt(var(data))*n^(-1/5);
t0 = min(data)-1;
tm = max(data)+1;
bins = t0:h:tm;
vk = histc(data,bins);
vk(end) = [];
fhat = vk/(n*h);
bc = (t0+h/2):h:(tm-h/2);
% plot
figure(2)
bar(bc,fhat,1,'w')
hold on
xlabel('Heights')
ylabel('Probability Density')
title('Epanchnikov Kernel Density Estimation')

% choose an appropriate domain
x = linspace(140,180,100); % domain
% sample size of MC sampling
n = 100;

% Density estimate using Epanechnikov

% adjust smoothing parameter for the Epanchnikov kernel
h = 1.06*std(data)*n^(-1/5);
h = h*(30*sqrt(pi))^(1/5)*.5;

% initialize vector for estimated pdf
fhat = zeros(size(x));

% sample from heights data
ind = unidrnd(length(heights),1,n);
data = heights(ind);

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

% plots
lineepan = plot(x,fhat,'Color','r');
axis([140 180 0 .075])
hold off