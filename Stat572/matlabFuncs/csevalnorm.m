function prob = csevalnorm( x,mu,covMat )
% This function calculates the mutivariate normal probability density
% Example 2.11, Martinez
    [n,d]=size(x);
    % center the data points
    x=x-ones(n,1)*mu;
    a=(2*pi)^(d/2)*sqrt(det(covMat));
    arg=diag(x*inv(covMat)*x');
    prob=exp((-.5)*arg);
    prob=prob/a;
end