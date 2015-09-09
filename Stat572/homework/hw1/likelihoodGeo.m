%in-class lab, September 4.
%Geometric MLE exercise.
p=0.2
n=100
r=geornd(p,n,1);
ybar=mean(r);
phat1=mle('geometric',r);
phat2=(1+ybar)^(-1);
logL=inline('n*(ybar*log(1-p)+log(p))','n','ybar','p');
p=0:0.01:1;
y=logL(n,ybar,p);
plot(p,y)