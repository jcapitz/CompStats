%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 4.9: implement the example 4.5 in Martinez               %
% This is a discrete implementation of the Accept/Reject method     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; n=100; probabilities=[0.15,0.22,0.33,0.10,0.20]; q=ones(1,5)./5;
X=zeros(1,n); R=zeros(1,n); counta=0; countr=0; c=1.65;  freq=zeros(1,5);
for i=1:n
    while X(i) == 0
        Y=unidrnd(5);
        U=rand;
        if U <= probabilities(Y)/(c*q(Y))
            X(i)=Y;
            counta=counta+1;
        else
           R(i)=Y;
           countr=countr+1;
        end
    end
end

for i=1:5
    freq(i)=sum(X(:)==i)/n;
end

bar(freq,1)
title('Relative Frequency Distribution')
ylabel('% frequency')
xlabel('x variate')