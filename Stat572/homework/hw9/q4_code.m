% METROPOLIS-HASTINGS

% Set up function handle to evaluate the target distribution.
normpdfker = @(x,mu,sigma) exp(-0.5*((x-mu)/sig).^2);
mu = 0; sig = 1; % parameters for the gamma
% set up function handle to evaluate the proposal distribution
unipdf = @(theta1,theta2) 1./(theta2-theta1);

% 1.GENERATE RANDOM SAMPLE OF SIZE n
% Generate 20000 samples in the chain.
n = 2000; % random sample size
% initialize the chain
x = zeros(1,n);
x(1) = 20; %rand(1); % generate the starting point
d = 1;
for i = 2:n
    % generate a candidate from the proposal distribution. This will be a
    % proposal with parameters given by the previous value in the chain.
    theta1 = x(i-1)-d; theta2 = x(i-1)+d;
    y = unifrnd(theta1,theta2);
    % generate a uniform for comparison
    u = rand(1);
    alphaf = min([1, normpdfker(y,mu,sig)*unipdf(y-d,y+d)/...
        (normpdfker(x(i-1),mu,sig)*unipdf(x(i-1)-d,x(i-1)+d))]);
    if u <= alphaf
        x(i) = y;
    else
        x(i) = x(i-1);
    end
end
% burn-in %
x= x(0.02*n+1:n);

% 2. PLOT THE RESULTS
subplot(211)
plot(x)
xlabel('Iteration')
title('Markov Chain with NormalTarget','FontSize',14)
subplot(212)
[fhath, bc] = hist(x);
fhath = fhath/((bc(2)-bc(1))*sum(fhath));
bar(bc,fhath,1,'c')
hold on
plot(linspace(min(x)-0.5,max(x)+0.5,5000),normpdf(linspace(min(x),max(x),5000),mu,sig),'b','LineWidth',2);
xlabel('RS ')
ylabel('Density')
title('Metropolis-Hastings Random Sample', 'FontSize',14)
legend('Random Sample','Normal PDF')
hold off