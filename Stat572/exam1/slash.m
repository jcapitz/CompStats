function [x] = slash(y)
x = zeros(size(y));

for i = 1:length(y)
    if y(i) ~= 0
        x(i) = (1-exp(-y(i).^2/2))/((y(i).^2)*sqrt(2*pi));
    else
        x = 1/(2*sqrt(2*pi));
    end
end
