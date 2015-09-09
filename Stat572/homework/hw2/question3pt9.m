%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 3.9: Generate a uniform random samples of size 100       %
% and calculate quantiles p=.33, p=.40, p=.63, p=.90.               %
% Modified code from Martinez, example 3.6                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% First generate some uniform(0,1) data.
x = rand(100,1);
% Now get the order statistics. These will serve
% as the observed values for the ordinate (Y_obs).
xs=sort(x);
% Now get the observed values for the abscissa (X_obs).
n=length(x);
phat = ((1:n)-0.5)/n;
% We want to get the quartiles.
p = [0.33, 0.40, 0.63, 0.90];
% The following provides the estimates of the quartiles
% using linear interpolation.
qhat=interp1(phat,xs,p);
