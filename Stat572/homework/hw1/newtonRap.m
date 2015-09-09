maxIt=1000000;%maximum number of iterations
tol=0.00001;%desired tolerance level
p0=0.2;%initialization of parameter
r=geornd(.2,100,1);
ybar=mean(r);
phat=p0+(1-p0-p0*ybar)*p0;%initial point estimate
count=0;

while abs(p0-phat)>tol==1
    p0=phat;
    phat=p0+(1-p0-p0*ybar)*p0;%calculate
    count=count+1;
end
count
phat