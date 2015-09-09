%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script calculates P(X<3) and P(X>5) for a normal pdf with    %
% mean=5, standard deviation=2 using both normspec() and normcdf()  %
% MATLAB functions.                                                 %
% Exercise 2.17, Martinez                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Func_Normspec=[normspec([5,inf],5,2);normspec([-inf,3],5,2)];
Func_Normcdf=[1-normcdf(5,5,2);normcdf(3,5,2)];
Probability=['p(X>5)';'p(X<3)']
T=table(Probability,Func_Normspec, Func_Normcdf)
