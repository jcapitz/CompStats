% Based on Example 7.3 - Matinez

% Get several values for the mean under the alternative
% hypothesis. Note that we are getting some values
% below the null hypothesis.
mualt = 40:60;

% Note the critical value:
cv = 1.645;
% Note the standard deviation for x-bar:
sig = 1.5;
% It's easier to use the unstandardized version, 
% so convert:
ct = cv*1.5 + 45;

% Get a vector of ct values that is 
% the same size as mualt.
ctv = ct*ones(size(mualt));
% Now get the probabilities to the left of this value.
% These are the probabilities of the Type II error.
beta = normcdf(ctv,mualt,sig);

% Plot probablity of a type II error vs. true mean
% under the alternative hypothesis
plot(mualt,beta);
xlabel('True Mean \mu')
ylabel('Probability of Type II Error')
axis([40 60 0 1.1])
