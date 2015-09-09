% BOOTSTRAP PCT CONFIDENCE INTERVAL
clear; counter = 0;
B = 500; thetahatb = zeros(1,100);
meand = 2; stdev = 1;

for i=1:100
    % generate data and calculate stat of interest
    rs = normrnd(meand,stdev,1,20);
    thetahat = median(rs);
    
    % set up the Bootstrap
    B = 500;
    bvals = bootstrp(B, @(x) median(x),rs);
    
    % calculate the Bootstrap SE
    seb = std(bvals);
    
    % find the bootstrap percentile interval
    alpha = 0.05;
    k = round(B*alpha/2);
    thetab = sort(bvals);
    blo = thetab(k);
    bhi = thetab(B-k);
    if bhi >= 2 && blo <= 2
        counter =counter + 1;
    end
    thetahatb(i) = mean(bvals);
end
hist(thetahatb)
set(get(gca,'child'),'FaceColor',[.9 .9 .9],'EdgeColor','black');
title('Boostrapped Estimated Median Histogram')
ylabel('Frequency'); xlabel('Estimated Median for each of the 100 runs')