
n=100;   u=rand(n,1);
x=linspace(-5,5,n);
y=slash(x);   figure(1);   plot(x,y);


for i=1:length(x)
    c=x(i);
    F(i)=quad(@(c) slash(c),-5,c);
end
figure(2);   plot(x,F)

for j=1:n
FF=5*ones(n,1);
for k=1:n
    if F(k) >= u(j)
        FF(k)=x(k);
    end
end
FS(j)=min(FF);
end

figure(3)
y= trapz(FS);

figure(4)
hist(FS)
axis([-4 4 0 300])

figure(5)
cdfplot(FS);