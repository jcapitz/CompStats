% METROPOLIS-HASTINGS INCLASS EXERCISE

addpath ~/Documents/Stat572/myfunctions
% Set up function handle to evaluate the Beta.
% Note that in both of the functions, 
% the constants are canceled.
betapdfker = @(x,a,b) (x.^(a-1)).*((1-x).^(b-1));
a = 0.5; b = 0.5; % parameters for the beta
% set up function handle to evaluate the proposal distribution
unipdf = @(theta1,theta2) 1./(theta2-theta1);

% 1.GENERATE RANDOM SAMPLE OF SIZE n

% Generate 10000 samples in the chain.
n = 10000; % random sample size
% set up Monte Carlo simulations
M = 100;
ISE = zeros(1,M);
MSE1 = zeros(1,M); MSE2 = zeros(1,M); MSE3 = zeros(1,M);
x0MSE1 = 0.2; x0MSE2 = 0.5; x0MSE3 = 0.8;% to calculate MSE
d = 1;
for j = 1:M
    % initialize the chain
    x = zeros(1,n);
    x(1) = rand(1); % generate the starting point
    for i = 2:n
        % generate a candidate from the proposal distribution. This will be a
        % proposal with parameters given by the previous value in the chain.
        theta1 = max(0,x(i-1)-d);
        theta2 = min(x(i-1)+d,1);
        y = unifrnd(theta1,theta2,1,1);
        % generate a uniform for comparison
        u = rand(1);
        alphaf = min([1, betapdfker(y,a,b)*unipdf(y-d,y+d)/...
            (betapdfker(x(i-1),a,b)*unipdf(x(i-1)-d,x(i-1)+d))]);
        if u <= alphaf
            x(i) = y;
        else
            x(i) = x(i-1);
        end
    end
    % burn-in 5%
    x= x(0.05*n+1:n);
    x0 = min(x); xn = max(x); % set up domain for kernel estimator
    
    % 2. KERNEL DENSITY ESTIMATION
    
    fhatker = kernelDensEst(x0,xn,x); % my kernel est function
    domain = linspace(x0,xn,5000);
    ISE(j) = trapz(domain,(fhatker-betapdf(domain,a,b)).^2);
    x0ind1 = find(domain>x0MSE1-0.001 & domain<x0MSE1+0.001);
    x0ind2 = find(domain>x0MSE2-0.001 & domain<x0MSE2+0.001);
    x0ind3 = find(domain>x0MSE3-0.001 & domain<x0MSE3+0.001);
    % take mean of MSE because sometimes the x0ind interval may contain 
    % more than one x0
    MSE1(j) = mean((betapdf(x0MSE1,a,b)-fhatker(x0ind1)).^2);
    MSE2(j) = mean((betapdf(x0MSE2,a,b)-fhatker(x0ind2)).^2);
    MSE3(j) = mean((betapdf(x0MSE3,a,b)-fhatker(x0ind3)).^2);
end

% 3. MONTE CARLO SIMULATION OF ISE AND MSE OF RS BASED KERNEL ESTIMATE
ISE = mean(ISE);
MSE1 = mean(MSE1);
MSE2 = mean(MSE2);
MSE3 = mean(MSE3);
fprintf('\nISE = %2.6f',ISE)
fprintf('\nMSE when xo = 0.2: %2.6f',MSE1)
fprintf('\nMSE when xo = 0.5: %2.6f',MSE2)
fprintf('\nMSE when xo = 0.8: %2.6f\n',MSE3)

% 4. PLOT THE RESULTS

[fhath, bc] = hist(x);
fhath = fhath/((bc(2)-bc(1))*sum(fhath));
bar(bc,fhath,1,'w')
hold on
domain = linspace(min(x),max(x),5000);
lineker = plot(domain,fhatker);
hold on
linebetapdf = plot(linspace(0,1,5000),betapdf(linspace(0.025,0.975,5000),a,b),'--r');
axis([-0.05 1.05 0 3])
xlabel('Random Sample with a Beta Target')
ylabel('Probability Density Function')
title('Metropolis-Hastings Random Sample', 'FontSize',14)
legend([lineker,linebetapdf],'Normal Kernel Estimate','Actual Beta PDF')
hold off