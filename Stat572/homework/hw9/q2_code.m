% METROPOLIS-HASTINGS TO GENERATE BETA SAMPLES

% Set up function handle to evaluate the Beta.
betapdfker = @(x,a,b) (x.^(a-1)).*((1-x).^(b-1));
a = 0.5; b = 0.5; % parameters for the beta
% set up function handle to evaluate the proposal distribution
unipdf = @(theta1,theta2) 1./(theta2-theta1);

% 1.GENERATE RANDOM SAMPLE OF SIZE n
% Generate 10000 samples in the chain.
n = 2000; % random sample size
% initialize the chain
x = zeros(1,n);
x(1) = rand(1); % generate the starting point
d = 1;
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
% burn-in 2%
x= x(0.02*n+1:n);

% 2. PLOT THE RESULTS
subplot(211)
plot(x)
xlabel('Iteration')
title('Markov Chain with Beta Target', 'FontSize',14)
subplot(212)
[fhath, bc] = hist(x);
fhath = fhath/((bc(2)-bc(1))*sum(fhath));
bar(bc,fhath,1,'c')
hold on
linebetapdf = plot(linspace(0,1,5000),betapdf(linspace(0.025,0.975,5000),a,b),'b','LineWidth',2);
xlabel('RS')
ylabel('Density')
title('Metropolis-Hastings Random Sample', 'FontSize',14)
legend('Random Sample','Beta PDF')
hold off