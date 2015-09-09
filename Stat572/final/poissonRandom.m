function [Z] = poissonRandom(lam,l,k,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inputs: lam = parameter for the poisson; l = parameter for Z interval %
%         k = size of X, n = size on random sample                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERATE Xi
% initialize
X = zeros(k,1);
Z = zeros(n,1);
for j = 1:n
    for i = 1:k
        % Generate the exponential random variables.
        uni = rand(1,i);
        y = -log(uni)/lam;
        X(i) = sum(y);
    end
    hits = X >= l-1 & X<l;
    Z(j) = sum(hits);
end
edges = 0:max(Z);
fhat = histc(Z,edges);

figure(1)
subplot(121)
bar(edges,fhat/n,1)
subplot(122)
bar(0:5,poisspdf(0:5,1),1)