% Set up function handle to evaluate the von Mises kernel.
vonmisespdfker = @(x,b) exp(b.*cos(x));
b = 3; % parameters for the von mises

% generate the MC
n = 1000;
mc = zeros(1,n);
mc(1) = 2; % generate the starting point
for i = 2:n
    % generate a candidate from the random walk
    y = mc(i-1)+unifrnd(-1,1);
    % generate a uniform for comparison
    u = rand(1);
    alphaf = min([1, vonmisespdfker(y,b)/(vonmisespdfker(mc(i-1),b))]);
    if u <= alphaf
        mc(i) = y;
    else
        mc(i) = mc(i-1);
    end
end
% burn-in 10 pct
mcb= mc(0.1*n+1:n);

% plots
figure(1)
subplot(2,1,1)
plot(mc) % entire MC
title('Markov Chain Generated Using Random Walk Sampler')
xlabel('Iterations')
subplot(2,1,2)
hist(mc)
title('Distribution of the Markov Chain - von Mises Target')
xlabel('Value of Markov Chain Sample')
ylabel('frequency')


figure(2)
subplot(2,1,1)
plot(mcb) % burned in MC
subplot(2,1,2)
hist(mcb)