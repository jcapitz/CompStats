f = @(x) q2pdf(x);
c = 0.5;
n=300;  % generate 100 rv's
% set up the arrays to store variates
x = zeros(1,n); % random variates
xy = zeros(1,n); % corresponding y values
rej = zeros(1,n); % rejected variates
rejy = zeros(1,n); % corresponding y values
irv=1;			
irej=1;
while irv <= n
   y = unifrnd(2,6);  % random number from g(y)
   u = unifrnd(2,6);  % random number for comparison
   if u <= f(y)/(0.25*c);
      x(irv)=y;
      xy(irv) = u*c;
      irv=irv+1;
   else
      rej(irej)= y;
      rejy(irej) = u*c; % really comparing u*c<=2*y
      irej = irej + 1;
   end
end
figure(1)
plot(x,xy,'o',rej,rejy,'*')
axis square %([0 1 0 c])
title('Accepted/Rejected')

figure(2)
[fr,x]=hist(x);
h=x(2)-x(1);
bar(x,fr/(n*h),1,'w')
title('Frequency Histogram of Random Sample')
hold on

x = linspace(2,6);
y = zeros(size(x));
for i = 1:length(x)
    y(i) = q2pdf(x(i));
end
plot(x,y);
hold off
probrej = irej/(irej+n);
