% Monte Carlo trials
M = 1000;
MSE = zeros(1,M);
MSEBIN = [];
for B = 5:5:40
    for i = 1:M;
        n=100;
        x=randn(n,1);
        % Get the histogram-default is 10 bins.
        [vk,bc]=hist(x,B);
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
    MSEBIN = [MSEBIN,MSE];
end
x= 5:5:40;
plot(x,MSEBIN)
title('Bin Width vs MSE')
ylabel('MSE')
xlabel('Number of Bins')