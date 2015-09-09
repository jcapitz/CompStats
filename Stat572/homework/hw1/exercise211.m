%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function finds the max for a normal pdf with mean=3,         %
% variance=1                                                        %
% Exercise 2.11, Martinez                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=linspace(0,6);
fminbnd(@(x) -normpdf(x,3,1),0,6)