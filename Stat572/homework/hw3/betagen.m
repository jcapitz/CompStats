%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 4.7: implement the alternative method of generating      %
% Beta random variables as described in exercise 4.7 - Martinez     %
% This script iterates until a random sample of size n is generated %
% User specifies alpha, beta, and the sample size n.                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X] = betagen(alpha,beta,n)
X = [];
while length(X) < n
    for i = length(X)+1:n
        u1 = rand;
        u2 = rand;
        y1 = u1^(1/alpha);
        y2 = u2^(1/beta);
        if y1 + y2 <= 1
            x = y1/(y1 + y2);
            X = [X,x];
        end
    end
end
figure
hist(X)
title(['Beta RV with alpha=' num2str(alpha) ' and beta=' num2str(beta)])
    