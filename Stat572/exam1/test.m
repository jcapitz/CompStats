n=1000;
u=rand(n,1); x=linspace(-5,5,n); y=slash(x);
figure(1); plot(x,y);

for i=1:length(x)
F(i)=quad(@(x) SD(x),-5,x(i));
end

figure(2);
plot(x,F)

for j=1:n

FF=5*ones(n,1);

for k=1:n
if F(k) >= u(j)
FF(k)=x(k);
end
end

PDFSLASH(j)=min(FF);

end

figure(3);
hist(PDFSLASH); axis([-4 4 0 300]);
figure(4);
cdfplot(PDFSLASH);

% Monte Carlo
M= 200;
MUHAT= mean(PDFSLASH);
SIGMAHAT= std(PDFSLASH);

for i= 1:M
RS = normrnd(MUHAT,SIGMAHAT,1,n);
PAR(i)= median(RS);
end

alpha= 0.05;
ind= find( PAR > 1);
PVAL= length(ind)/M
cv= csquantiles(PAR, alpha);

figure(5); 

hist(PAR); hold on; plot(cv, 0, 'ro'); hold off