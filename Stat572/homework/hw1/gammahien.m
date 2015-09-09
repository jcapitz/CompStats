clear
clc

% In Class Problem
size= 1000;   u= rand(size,1);
alpha= 3;   beta= 2;
x= 0:0.1:20;

for i= 1:length(x)
    a= x(i);
    gamCDF(i)= quad(@(a) csgammp(a,alpha,beta),0,a);
end

for j=1:size
    gamPDF(j) = min( x( find( gamCDF >= u(j) ) ) );
end

subplot(121)
hist(gamPDF);
title('Gamma PDF Alternative Procedure')
xlim([0,8])

subplot(122)
hist(csgamrnd(1000,alpha,beta));
title('Gamma PDF cs Procedure')
xlim([0,8])