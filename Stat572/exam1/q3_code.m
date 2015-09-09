theta = quad('exp(x.^2)',0,1);
MSE1 = zeros(1,100);
MSE2 = zeros(1,100);
for i = 1:100
    u = unifrnd(0,1,1);
    u1 = unifrnd(0,1,1);
    u2 = unifrnd(0,1,1);
    thetahat1 = (1/2)*exp(u.^2)*(1+exp(1-2*u));
    thetahat2 = (1/2)*(exp(u1.^2)+exp(u2.^2));
    MSE1(i) = abs(theta - thetahat1)^2;
    MSE2(i) = abs(theta - thetahat2)^2;
end
MSE1 = mean(MSE1);
MSE2 = mean(MSE2);
