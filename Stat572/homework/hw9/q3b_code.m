% METROPOLIS-HASTINGS

% Set up function handle to evaluate the gamma.
gammapdfker = @(x,a,b) (x.^(a-1)).*exp(-x./b);
a = 2; b = 3; % parameters for the gamma
% set up function handle to evaluate the proposal distribution
unipdf = @(theta1,theta2) 1./(theta2-theta1);

% 1.GENERATE RANDOM SAMPLE OF SIZE n
% Generate 20000 samples in the chain.
n = 2000; % random sample size
% initialize the chain
x = zeros(1,n);
x(1) = 1; %rand(1); % generate the starting point
d = 5;
for i = 2:n
    % generate a candidate from the proposal distribution. This will be a
    % proposal with parameters given by the previous value in the chain.
    theta1 = max(0,x(i-1)-d);
    theta2 = x(i-1)+d;
    y = unifrnd(theta1,theta2,1,1);
    % generate a uniform for comparison
    u = rand(1);
    alphaf = min([1, gammapdfker(y,a,b)*unipdf(y-d,y+d)/...
        (gammapdfker(x(i-1),a,b)*unipdf(x(i-1)-d,x(i-1)+d))]);
    if u <= alphaf
        x(i) = y;
    else
        x(i) = x(i-1);
    end
end
% burn-in 5%
x= x(0.05*n+1:n);

% 2. PLOT THE RESULTS
subplot(211)
plot(x)
xlabel('Iteration')
title('Markov Chain with Metropolis-Hastings and Gamma Target','FontSize',14)
subplot(212)
[fhath, bc] = hist(x);
fhath = fhath/((bc(2)-bc(1))*sum(fhath));
bar(bc,fhath,1,'c')
hold on
plot(linspace(0,max(x)+5,5000),gampdf(linspace(0,max(x),5000),a,b),'b','LineWidth',2);
xlabel('Random Sample with a Gamma Target')
ylabel('Probability Density Function')
title('Metropolis-Hastings Random Sample', 'FontSize',14)
legend('Random Sample','Actual Gamma PDF')
hold off