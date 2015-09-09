% generate data set
n = 1000;
data = randn(1,n);
% monte carlo trials
M = 100;
xo = 0;
MSEHIST = zeros(1,M); MSEFREQ = zeros(1,M); MSEKER = zeros(1,M);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HISTOGRAM %
for i = 1:M
    % generate dataset
    data = randn(1,n);
    % Use Normal Reference Rule for bin width.
    h = 3.5*std(data)*n^(-1/3);
    % Get the bin mesh. Put some extra space on the ends.
    t0 = min(data) - 1;
    tm = max(data) + 1;
    rng = tm - t0;
    nbin = ceil(rng/h);
    bins = t0:h:(nbin*h + t0);
    % Get the bin counts vk.
    vk = histc(data,bins);
    
    % Normalize to make it a bona fide density.
    fhathist = vk/(n*h);
    fhathist(end) = [];
    
    % To plot this, use bar with the bin centers.
    tm = max(bins);
    bc = (t0+h/2):h:(tm-h/2);
    
    % calculate MSE
    % Now return an estimate at a point xo.
    % Find all of the bin centers less than xo.
    ind = find(bc < xo);
    % xo should be between these two bin centers.
    b1 = bc(ind(end));
    b2 = bc(ind(end)+1);
    % Put it in the closer bin.
    if (xo-b1) < (b2-xo)   % then put it in the 1st bin
        fhathist0 = vk(ind(end))/(n*h);
    else
        fhathist0 = vk(ind(end)+1)/(n*h);
    end
    MSEHIST(i) = (fhathist0 - normpdf(xo))^2;
end
MSEHIST = mean(MSEHIST);
figure(1)
bar(bc,fhathist,1,'w')
xlabel('Normal Random Variable')
ylabel('Probability')
title('Histogram Density Estimation')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FREQUENCY POLYGON %
for i = 1:M
    % generate dataset
    data = randn(1,n);
    % Use Normal Reference Rule for bin width
    % of frequency polygon.
    h = 2.15*sqrt(var(data))*n^(-1/5);
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
    
    % calculate MSE
    % Now return an estimate at a point xo.
    % Find all of the bin centers less than xo.
    ind = find(bc < xo);
    % xo should be between these two bin centers.
    b1 = bc(ind(end));
    b2 = bc(ind(end)+1);
    % Put it in the closer bin.
    if (xo-b1) < (b2-xo)   % then put it in the 1st bin
        fhatfreq0 = vk(ind(end))/(n*h);
    else
        fhatfreq0 = vk(ind(end)+1)/(n*h);
    end
    MSEFREQ(i) = (fhatfreq0 - normpdf(xo))^2;
end
MSEFREQ = mean(MSEFREQ);
figure(2)
bar(bc,fhatfreq,1,'w')
hold on
plot(xinterp,fp)
hold off
xlabel('Normal Random Variable')
ylabel('Probability')
title('Frequency Polygon Density Estimation')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NORMAL KERNERL %

% choose an appropriate domain
x = linspace(-4,4,1000); % domain

% find the index for x = x0 = 5
x0ind = find(x>-0.999 & x<0.009);

for j = 1:M
    % initialize vector for estimated pdf
    fhatker = zeros(size(x));
    % sample from normal
    data = randn(1,n);
    % choose smoothing parameter
    h = 1.06*std(data)*n^(-1/5);
    
    % evaluate using the normal kernel for each data point
    % at all x in the domain
    for i=1:n
        % get each kernel function evaluated at x
        % centered at data and weighted by h
        f=exp(-(1/(2*h^2))*(x-data(i)).^2)/sqrt(2*pi)/h;
        % add each ith average f vector to get estimate pdf height
        fhatker = fhatker+f/(n);
    end
    % Calculate the expected value of the MSE for x = x0, normal kernel
    MSEKER(j) = mean((normpdf(xo)-fhatker(x0ind)).^2);
end
MSEKER = mean(MSEKER);

figure(3)
bar(bc,fhatfreq,1,'w')
hold on
plot(x,fhatker)
xlabel('Normal Random Variable')
ylabel('Probability')
title('Normal Kernel Density Estimation')
hold off