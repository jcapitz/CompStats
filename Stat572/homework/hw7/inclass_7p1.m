addpath ~/Documents/Stat572/CompStatsToolboxV2
% 1. CREATE 3-TERM DATASET, n=100
data = [normrnd(-2.5,1,1,50),normrnd(4.5,sqrt(2),1,15)...
    ,normrnd(10.5,sqrt(3),1,35)];
n = length(data);

% 2. ESTIMATE THE DENSITY FOR ABOVE DATA USING NORMAL KERNEL
% choose an appropriate domain
x = linspace(-10,20,5000); % domain

% choose smoothing parameter
h = 1.06*std(data)*n^(-1/5); 

% evaluate using the normal kernel for each data point 
% at all x in the domain
fhat = zeros(size(x));
for i=1:n
    % get each kernel function evaluated at x
    % centered at data and weighted by h
    f=exp(-(1/(2*h^2))*(x-data(i)).^2)/sqrt(2*pi)/h;
    % add each ith average f vector to get estimate pdf height
    fhat = fhat+f/(n);
end


% 3. USE FINITE MIXTURE TO ESTIMATE DENSITY OF DATA, c=3
% Set initial model to means at 50 and 80.
muin = [-1, 4, 9];
% Set mixing coefficients equal.
piesin = [0.5, 0.25, 0.25];
% Set initial variances to 1.
varin = [1, 1, 1];
max_it = 100;
tol = 0.001;
% Call the finite mixtures.
[pies,mus,vars]=...
    csfinmix(data,muin,varin,piesin,max_it,tol);

% 4. PLOT THE RESULTS

% Histogram estimate of the PDF
% Use Normal Reference Rule for bin width
% of frequency histogram.
h = 2.15*sqrt(var(data))*n^(-1/5)*0.25;
t0 = min(data)-1;
tm = max(data)+1;
bins = t0:h:tm;
vk = histc(data,bins);
vk(end) = [];
fhath = vk/(n*h);
bc = (t0+h/2):h:(tm-h/2);

% Plotting
bar(bc,fhath,1,'w')
hold on
xlabel('X - variable')
ylabel('Probability Density Function')
title('Density Estimation')
linenorm = plot(x,fhat,'--r');
hold on
linemix = csplotuni(pies,mus,vars,min(x),max(x),length(x));
legend([linenorm,linemix],'Normal Kernel Estimate','Finite Mixture Estimate')
hold off

% GENERATE RANDOM SAMPLES OF SIZE 1000 FROM EACH METHOD

% Kernel Method
% The model is defined as a kernel density estimation model with n
% component distributions

% The weights for each component kernel is 1/n
% thus create a vector (p1, p1+p2, p1+p2+p3...)
p = (1/n):(1/n):1;

% Set up the random sample generation procedure
k = 1000; musk = zeros(1,k);

% this loop generates the means from the kernel vector from the original
% data
for i = 1:k
    u = rand;
    for j = 1:length(p)-1
        if u >= p(j) && u <= p(j+1)
            musk(i) = data(j);
        end
    end
end

% This generates the actual random sample variables
rsk = rand(1,k)*h + musk;

% Finite mixture method

% Now generate some random variables from this model.
% Get the true model to generate data from this.
rsmx = zeros(k,1);
% Now generate k random variables. First find
% the number that fall in each one.
r = rand(1,k);
% Find the number generated from component 1.
ind1 = length(find(r <= pies(1)));
ind2 = length(find(r > pies(1) & r <= pies(1)+pies(2)));
% Create some mixture data. Note that the 
% component densities are normals.
rsmx(1:ind1) = randn(ind1,1)*sqrt(vars(1)) + mus(1);
rsmx(ind1+1:ind1+ind2) = randn(ind2,1)*sqrt(vars(2)) + mus(2);
rsmx(ind1+ind2+1:k) = randn(k-ind1-ind2,1)*sqrt(vars(3)) + mus(3);

% 6. DRAW HISTOGRAM OF BOTH RANDOM SAMPLES AND COMPARE

% Create histograms 
figure (2)
subplot(121);
histdata = hist(rsk)./k;
xhist = linspace(min(rsk)+1,max(rsk)-1,length(histdata));
bar(xhist,histdata,1,'w')
axis([(min(rsk)-1) (max(rsk)+1) 0 (max(histdata)+.05)]) 
xlabel('Random Sample from Kernel Method'); ylabel('Density')
title('Kernel Random Sample')

subplot(122);
histdata = hist(rsmx)./k;
xhist = linspace(min(rsmx)+1,max(rsmx)-1,length(histdata));
bar(xhist,histdata,1,'w')
axis([(min(rsmx)-1) (max(rsmx)+1) 0 (max(histdata)+.05)])
xlabel('Random Sample from Finite Mixture Method'); ylabel('Density')
title('Finite Mixture Random Sample')