% Based on example 7.3

% Generate the mean under the alternative
mualt = 40:60;

% Note the critical value:
cv = 1.645;
% Note the standard deviation for x-bar:
sig=15./sqrt([50,100,200]);

% It's easier to use the unstandardized version, 
ct = cv.*sig + 45;

% Get a vector of ct values that is 
% the same size as mualt.
one = ones(size(mualt));
ctv = [ct(1)*one;ct(2)*one;ct(3)*one];

% Now get the probabilities to the left of this value.
% These are the probabilities of the Type II error.
beta50 = normcdf(ctv(1,:),mualt,sig(1));
beta100 = normcdf(ctv(2,:),mualt,sig(2));
beta200 = normcdf(ctv(3,:),mualt,sig(3));

% To get the power: 1-beta
pow50 = 1 - beta50;
pow100 = 1 - beta100;
pow200 = 1 - beta200;

plot(mualt,pow50,'r-o');
hold on
plot(mualt,pow100,'-*');
hold on
plot(mualt,pow200,'--');
xlabel('True Mean \mu')
ylabel('Power')
axis([40 60 0 1.1])
legend('Power for n=50','Power for n=100','Power for n=200',2)
hold off
