% generate sample data from exponential of size k
lam = 1; k = 100; l = 5;
SampleY = zeros(k,k);
Z = zeros(1,k);
for j = 1:k
    for i = 1:k
        SampleY(i,1:i) = exprnd(lam,1,i);
    end
    SampleX = sum(SampleY,2);
    hits = SampleX >= l-1 & SampleX<l;
    Z(j) = sum(hits);
end

% generate B bootstraps
B = 2000;
inds = unidrnd(k,k,B);
xboot = Z(inds);
edges = 0:max(Z);
fhat = histc(xboot,edges);
fhat = mean(fhat,2);

figure(1)
subplot(121)
bar(edges,fhat/k,1)
subplot(122)
bar(0:5,poisspdf(0:5,1),1)

