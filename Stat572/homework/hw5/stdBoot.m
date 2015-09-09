% Code for in-class Bootstrap CI comparison

% STANDARD BOOTSTRAP CI
counter = 0; B = 500;
meand = 2; stdev = 1;
thetahatb = zeros(1,100);

for i=1:100
    % generate data and calculate stat of interest
    rs = normrnd(meand,stdev,1,20);
    thetahat = median(rs);
    
    % set up the Bootstrap
    bvals = bootstrp(B, @(x) median(x),rs);
    
    % calculate the Bootstrap SE
    seb = std(bvals);
    
    % calculate the CI
    alpha = 0.05;
    cilo = thetahat-norminv(1-alpha/2,0,1)*seb;
    cihi = thetahat-norminv(alpha/2,0,1)*seb;
    if cihi >= 2 && cilo <= 2
        counter = counter + 1;
    end
    thetahatb(i) = mean(bvals);
end
hist(thetahatb)
set(get(gca,'child'),'FaceColor',[.9 .9 .9],'EdgeColor','black');
title('Boostrapped Estimated Median Histogram')
ylabel('Frequency'); xlabel('Estimated Median for each of the 100 runs')
