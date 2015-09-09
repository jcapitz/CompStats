%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 3.11: Generate results for examples 3.5 and 3.6 in       %
% Martinez, using lager sample sizes, n1=100000 and n2=500000.      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% example 3.5
% generate the random sample and sort
x=sort(rand(1,100000));
% find the median of the lower half - first quartile
q1=median(x(1:50000)); 
% find the median
q2=median(x);
% find the median of the upper half - third quartile
q3=median(x(50001:100000));
qhat3_5=[q1,q2,q3];

%example 3.6
% First generate some standard normal data.
x = randn(500000,1);
% Now get the order statistics. These will serve
% as the observed values for the ordinate (Y_obs).
xs=sort(x);
% Now get the observed values for the abscissa (X_obs).
n=length(x);
phat = ((1:n)-0.5)/n;
% We want to get the quartiles.
p = [0.25, 0.5, 0.75];
% The following provides the estimates of the quartiles
% using linear interpolation.
qhat3_6=interp1(phat,xs,p);
