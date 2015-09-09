% BOOTSTRAP t-CONFIDENCE INTERVAL
counter = 0;
B = 500; thetahatb = zeros(1,100);
meand = 2; stdev = 1;
alpha = 0.05;

for i =1:100
    % generate data and calculate stat of interest
    rs = normrnd(meand,stdev,1,20);
    thetahat = median(rs);
    
    % Get the bootstrap replicates and samples.
    [bootreps, bootsam] = bootstrp(B,@(x) median(x),rs);
    % Set up some storage space for the SEs.
    sehats = zeros(size(bootreps));
    % Each column of bootsam contains indices
    % to a bootstrap sample.
    for j = 1:B
        % extract the sample from the data
        xstar = rs(bootsam(:,j));
        bvals(j) = median(xstar);
        % Do bootstrap using that sample to estimate SE.
        sehats(j) = std(bootstrp(20,@(x) median(x),xstar));
    end
    zvals = (bootreps - thetahat)./sehats;
    
    % Estimate the SE using the bootstrap.
    SE = std(bootreps);
    
    % Get the quantiles.
    k = round(B*alpha/2);
    szval = sort(zvals);
    tlo = szval(k);
    thi = szval(B-k);
    % Get the endpoints of the interval.
    cilo = thetahat-thi*SE;
    cihi = thetahat-tlo*SE;
    if cihi >= 2 && cilo <= 2
        counter = counter + 1;
    end
    thetahatb(i) = mean(bootreps);
end
hist(thetahatb)
set(get(gca,'child'),'FaceColor',[.9 .9 .9],'EdgeColor','black');
title('Boostrapped Estimated Median Histogram')
ylabel('Frequency'); xlabel('Estimated Median for each of the 100 runs')
