%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 4.6: write a function to generate chi-square r.v from    %
% standard normal r.v.                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [X] = chigen(v,n)
X = zeros(1,n);
% generate the normal rv
for i = 1:n
    Z = randn(1,v);
    X(i) = sum(Z.^2);
end
hist(X);
title(['Chi-square Random Variable with ' num2str(v) ' Degrees of Freedom'])