% generate sample data from exponential of size k
lam = 1; n = 100; l = 5;
SampleY = zeros(n,n);
Z = zeros(1,n);
for j = 1:n
    for i = 1:n
        SampleY(i,1:i) = exprnd(lam,1,i);
    end
    SampleX = sum(SampleY,2);
    hits = SampleX >= l-1 & SampleX<l;
    Z(j) = sum(hits);
end
data = Z;
edges = 0:max(data);
fhat = histc(data,edges);
figure(1)
subplot(121)
bar(edges,fhat/n,1,'w')
hold on

% choose an appropriate domain
x = linspace(-0.5,5,5000); % domain

% choose smoothing parameter
h = 1.06*std(data)*n^(-1/5); 

% evaluate using the normal kernel for each data point 
% at all x in the domain
fhat = zeros(size(x));
for i=1:n
    % get each kernel function evaluated at x
    % centered at data and weighted by h
    f=exp(-(1/(2*h^2))*(x-data(i)).^2)/sqrt(2*pi)/h;
    % add each ith average f vector to get estimate pdf height
    fhat = fhat+f/(n);
end
linenorm = plot(x,fhat,'b');

hold off
subplot(122)
bar(0:5,poisspdf(0:5,1),1,'w')
