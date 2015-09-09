% initial value
x0 = 5;
betasAR = [0.4,0.5,.9,.999];
sigmaAR = 0.25;
n = 1000; m = length(betasAR);
x=[x0,zeros(1,n-1)];
arvar = zeros(n,m);

for k = 1:m
    for i=2:n
        x(i) = betasAR(k)*x(i-1)+normrnd(0,sigmaAR/(1-betasAR(k)));
    end
    arvar(:,k)= x;
    subplot(m,1,k)
    plot(x);
end



