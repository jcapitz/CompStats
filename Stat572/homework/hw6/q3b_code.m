% Monte Carlo trials
M = 1000;
MSE = zeros(1,M);
MSESAMP = [];
for n = 20:20:100
    for i = 1:M;
        x=randn(n,1);
        % Get the histogram-default is 10 bins.
        [vk,bc]=hist(x);
        % Get the bin width.
        h = bc(2)-bc(1);
        % Now return an estimate at a point xo.
        xo = 0;
        % Find all of the bin centers less than xo.
        ind = find(bc < xo);
        % xo should be between these two bin centers.
        b1 = bc(ind(end));
        b2 = bc(ind(end)+1);
        % Put it in the closer bin.
        if (xo-b1) < (b2-xo)   % then put it in the 1st bin
            fhat = vk(ind(end))/(n*h);
        else
            fhat = vk(ind(end)+1)/(n*h);
        end
        MSE(i) = (fhat - normpdf(xo))^2;
    end
    MSE  = mean(MSE);
    MSESAMP = [MSESAMP,MSE];
end
x = 20:20:100;
plot(x,MSESAMP)
title('Sample Size vs MSE')
ylabel('MSE')
xlabel('Sample Size')