%initialize
k = 1000; % generate a chain of size 1000
m = 100; % burn-in
x = zeros(1,k); y = zeros(1,k);
% starting point.
x(1) = 2.5; %exprnd(1/0.4); 
y(1) = 2.5; %exprnd(1/x(1));
ind = 2;
while ind < k+1
    xn = exprnd(1/y(ind-1));
    % condition for x domain
    if xn >= 0 && xn <= 10
        x(ind) = xn;
        yn = exprnd(1/x(ind));
        % condition for y domain
        if yn >= 0 && yn <= 10
            y(ind) = yn;
            ind = ind+1;
        end
    end
end

% statistics
Mean = [mean(x); mean(x(m:k))];
Variance = [var(x); var(x(m:k))];
Skewness = [skewness(x); skewness(x(m:k))];
Kurtosis = [kurtosis(x); kurtosis(x(m:k))];
method = {'Pre Burn-in' 'Post Burn-in'};
T = table(Mean, Variance, Skewness, Kurtosis, 'RowNames',method);

% pdf estimate
pdfpt = [0.1 1.8 3.5 9.2];
fhat = zeros(1,length(pdfpt));
for i = 1:length(pdfpt)
    fhat(i) = mean(exppdf(pdfpt(i),y(m:k)));
end

% plots
figure(1)
subplot(221)
plot(x)
title('Gibbs Sampler MC, no burn-in')
xlabel('Iterations')
subplot(222)
[fhath, bc] = hist(x);
fhath = fhath/((bc(2)-bc(1))*sum(fhath));
bar(bc,fhath,1,'b')
title('MC Histogram, no burn-in')
xlabel('x-variable')

subplot(223)
plot(x(m:k))
title('Gibbs Sampler MC, burn-in')
xlabel('Iterations')
subplot(224)
[fhath, bc] = hist(x(m:k));
fhath = fhath/((bc(2)-bc(1))*sum(fhath));
bar(bc,fhath,1,'b')
title('MC Histogram, burn-in')
xlabel('x-variable')