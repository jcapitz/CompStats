gen=rand(1,1000);

for i=1:length(gen)
    if gen(i)<=0.1
        y(i)=1;
    elseif gen(i) > 0.1 || gen(i)<= 0.2
        y(i)=2;
    else
        y(i)=3;
    end
end

u=rand(1,1000);

for i=1:length(u)
    if u....
