% Chap9Num19

data= randn(300,1);
c= 300;
% initial MUs                     % initial VARs
MUin= normrnd(0, 0.01, 1, c);      VARin= normrnd(1, 0.1, 1, c);   
%MUin= zeros(1, c);                VARin= ones(1, c);
PIin= (1/c)*ones(1, c);   % initial weights

% get a finite mixture model
max_it= 100;   tol= 0.001;
[PIs,MUs,VARs]= csfinmix(data, MUin, VARin, PIin, max_it, tol);

% generate random variables
n= 300;   x= zeros(n,1);   r= rand(1,n);
for i= 1:c
    ind= find( r>=sum(PIs(1:i-1)) & r<sum(PIs(1:i)) );
    x(ind)= randn(length(ind), 1) * sqrt(VARs(i)) + MUs(i);
end
            
subplot(121);   [N, h]= hist(data);   bar(h, N, 1, 'w');
subplot(122);   [N, h]= hist(x);   bar(h, N, 1, 'w');