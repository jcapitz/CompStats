%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lab 1. Implement the Fisher Scoring method on a     %
% simulated sample of size n drawn from a normal dis- %
% tribution with mean mu and variance sigma_squared   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIALIZATION BLOCK:                               %
% Set up of initial conditions: matIt is the max # of %
% iterations before stop. tol is the convergence tole-%
% rance. mu is the distribution mean; sigma_squared   %
% is the variance; theta_0 is the previous value of   %
% parameter vector; score is the score vector; and    %
% fishInfo is the information matrix.                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxIt=100000;
tol=0.000001;
theta_0=[1;2]; 
n=100;
x=normrnd(0,1,n,1);
mu_0=theta_0(1);
sig_sq_0=theta_0(2);
score=[(sum(x)-n*mu_0)/sig_sq_0;(-n/(2*sig_sq_0))+(sum((x-mu_0).^2)/(2*(sig_sq_0^2)))];
fishInfo=[n/sig_sq_0,0;0,n/(2*(sig_sq_0^2))];
theta_hat=theta_0+fishInfo\score; % theta_0 + inverse of fishInfo * score
count=0;

while norm(theta_0-theta_hat)>tol 
    theta_0=theta_hat;
    mu_0=theta_hat(1);
    sig_sq_0=theta_hat(2);
    score=[(sum(x)-n*mu_0)/sig_sq_0;(-n/(2*sig_sq_0))+(sum((x-mu_0).^2)/(2*(sig_sq_0^2)))];
    fishInfo=[n/sig_sq_0,0;0,n/(2*(sig_sq_0^2))];
    theta_hat=theta_0+fishInfo\score;
    count=count+1;
    if count >= maxIt
        break
    end
end
count;
theta_hat;