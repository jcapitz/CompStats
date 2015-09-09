% METROPOLIS-HASTINGS

% Set up function handle to evaluate the gamma.
gammapdfker = @(x,a,b) (x.^(a-1)).*exp(-x./b);
a = 2; b = 3; % parameters for the gamma
% set up function handle to evaluate the proposal distribution
exponential = @(x,lambda) (exp(-x./lambda))./lambda;

% 1.GENERATE RANDOM SAMPLE OF SIZE n
% Generate 20000 samples in the chain.
n = 2000; % random sample size
% initialize the chain
x = zeros(1,n);
x(1) = 1; %rand(1); % generate the starting point
for i = 2:n
    % generate a candidate from the proposal distribution. This will be a
    % proposal with parameters given by the previous value in the chain.
    lambda = max(0,x(i-1));
    y = exprnd(lambda);
    % generate a uniform for comparison
    u = rand(1);
    alphaf = min([1, gammapdfker(y,a,b)*exponential(x(i-1),y)/...
        (gammapdfker(x(i-1),a,b)*exponential(y,x(i-1)))]);
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
title('Markov Chain with Gamma Target','FontSize',14)
subplot(212)
[fhath, bc] = hist(x);
fhath = fhath/((bc(2)-bc(1))*sum(fhath));
bar(bc,fhath,1,'c')
hold on
plot(linspace(0,max(x)+5,5000),gampdf(linspace(0,max(x),5000),a,b),'b','LineWidth',2);
xlabel('RS')
ylabel('Density')
title('Metropolis-Hastings Random Sample', 'FontSize',14)
legend('Random Sample','Gamma PDF')
hold off