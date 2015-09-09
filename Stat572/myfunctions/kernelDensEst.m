%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function produces kernel density estimates        %
% based on the normal kernel                             %
% Inputs: a and b are the limits of the domain interval. %
% data is a 1xn vector of data points                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fhat] = kernelDensEst(a,b,data)
% initialize
n = length(data);
% ESTIMATE THE DENSITY FOR ABOVE DATA USING NORMAL KERNEL
% set up an appropriate domain
x = linspace(a,b,5000); % domain

% choose smoothing parameter
h = 1.06*std(data)*n^(-1/5); 

% evaluate using the normal kernel for each data point 
% at all x in the domain
fhat = zeros(size(x));
for i=1:n
    % get each kernel function evaluated at x
    % centered at data and weighted by h
    f=exp(-(1/(2*h^2))*(x-data(i)).^2)/sqrt(2*pi)/h;
    % add each ith average f vector to get estimate pdf height
    fhat = fhat+f/(n);
end