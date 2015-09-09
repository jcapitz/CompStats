% Exercise 7.11
clear;
% load population data
load lawpop

% find true variances for the lsat and gpa populations
popVar = var(lawpop,1);

% load sample data
load law

% BOOTSTRAP Procedure
B = 10000;	% number of bootstrap replicates

% get the bootstrap values for the variance based on sample data
bvals = bootstrp(B, @(x) var(x,1),law);

% get bootstrap estimates for the standar error and the bias
seb = std(bvals); biasb = mean(bvals)-popVar;

fprintf('Population Variance: LSAT= %4.3f, GPA=%4.3f\n\n',popVar(1), popVar(2))
fprintf('Bootstrap Variance Estimate: LSAT= %4.3f, GPA=%4.3f\n\n',mean(bvals(:,1)), mean(bvals(:,2)))
fprintf('Bootstrap Variance Std Error: LSAT= %4.3f, GPA=%4.3f\n\n',seb(1), seb(2))
fprintf('Bootstrap Variance Bias: LSAT= %4.3f, GPA=%4.3f\n\n',biasb(1), biasb(2))
fprintf('Bootstrap SE as pct of Pop Var: LSAT= %4.3f, GPA=%4.3f\n\n',seb(1)/popVar(1), seb(2)/popVar(2))
fprintf('Bootstrap Bias as pct of Pop Var: LSAT= %4.3f, GPA=%4.3f\n\n',biasb(1)/popVar(1), biasb(2)/popVar(2))