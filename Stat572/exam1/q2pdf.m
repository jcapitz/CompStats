function [y] = q2pdf(x)

if x<3 && x>=2
    y = (x-2)/2;
else x<=6 && x>=3;
    y = (2-(x/3))/2;
end

