%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script calculates P(X<x) for an exponential pdf using the    %
% function to integrate the exponential pdf in exercise 2.1,        %
% Martinez                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=[0;1;2;3;4;5;6;7];
MyProb=[expcprob_hw21(X(1),1)];
Matlab=[expcdf(X(1),1)];
for i=2:length(X)
    x(i)=expcprob_hw21(X(i),1);
    y(i)=expcdf(X(i),1);
    MyProb=[MyProb;x(i)];
    Matlab=[Matlab;y(i)];
end
T=table(X,MyProb,Matlab);