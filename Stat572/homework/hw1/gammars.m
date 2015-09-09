%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In-Class Exercise, September 11, 2014                             %
% Generate a sample of size 1000 from a Gamma distribution with     %
% parameters n and lambda.                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%initialize parameters
n=3;
lambda=2;
x=linspace(0,30);
F=zeros(1,length(x));
rs=zeros(1,1000);
% Loop thru uniforms and x vector picking x's that meet criteria
for i=1:1000 
    for j=1:length(x)
        if gamcdf(x(j),n,lambda)<rand
            F(j)=1;
        else
            F(j)=gamcdf(x(j),n,lambda);
        end
    end
    l=find(F==min(F));
    rs(i)=x(l);
end
figure
hist(rs)
title('Frequecy Histogram of Gamma Random Sample')
