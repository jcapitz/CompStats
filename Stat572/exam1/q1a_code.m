
%initialize parameters
n = 100; % sample size
x=linspace(-5,5,100);
F=zeros(size(x));
rs=zeros(size(x));
u=rand(1,100);

% Loop thru uniforms and x vector picking x's that meet criteria
for i=1:length(u)
    % this loops through the length x vector and assigns a 1 to vector F(j)
    % if the value of the slash cdf is less than a random uniform number
    % otherwise assigns the value of the slash cdf to F(j).
    for j=1:length(x)
        if quadgk(@(x)slash(x),-inf,x(j))<u(i)
            F(j)=1;
        else
            F(j)=quadgk(@(x)slash(x),-inf,x(j));
        end
    end
    % this looks at the vector F of length j generated above and finds the
    % index of the minimum in order to selec a sample from x at the jth
    % position. Excludes the min=1 because that means that all values are
    % 1 in the F vector.
    if min(F) ~= 1
        l=find(F==min(F));
        rs(i)=x(l);
    end
end

y = zeros(size(x));
g = y;
for i = 1:length(x);
    y(i) =  quadgk(@(x)slash(x),-100,x(i));
    g(i) = slash(x(i));
end
    
% plots
figure(1)
HIST =  hist(rs);
bar(-5:1.1:5,HIST/length(u),1,'w')
title('Frequecy Histogram of Slash Random Sample')
hold on
plot(x,g);
axis([-6 6 0 0.35])
hold off

figure(2)
plot(x,y);

figure(3)
cdfplot(rs);

% Monte Carlo
M= 1000;
MUHAT= mean(rs);
SIGMAHAT= std(rs);

for i= 1:M
rsho = SIGMAHAT*rand(1,n) + 1;
trs(i)= mean(rsho);
end

alpha= 0.05;
ind= find( trs >= median(rs));
PVAL= length(ind)/M;
cv= csquantiles(trs, alpha);