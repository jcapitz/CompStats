
% STANDARD BOOTSTRAP CI
load forearm
counter = 0; B = 500; counterv = zeros(1,50);
meand = mean(forearm); stdev = std(forearm);
thetahatb = zeros(1,100);
for k = 1:50
    for i=1:100
        % generate data and calculate stat of interest
        rs = normrnd(meand,stdev,1,20);
        thetahat = mean(rs);
        
        % set up the Bootstrap
        bvals = bootstrp(B, @(x) mean(x),rs);
        
        % calculate the Bootstrap SE
        seb = std(bvals);
        
        % calculate the CI
        alpha = 0.05;
        cilo = thetahat-(2)*seb;
        cihi = thetahat-(-2)*seb;
        if cihi >= meand && cilo <= meand
            counter = counter + 1;
        end
        thetahatb(i) = mean(bvals);
    end
    counterv(k) = counter;
    counter = 0;
end
pmean = mean(counterv);
pse = std(counterv)/sqrt(k);
alpha = 0.05;
ciplo = pmean-norminv(1-alpha/2,0,1)*pse;
ciphi = pmean-norminv(alpha/2,0,1)*pse;

hist(counterv)
set(get(gca,'child'),'FaceColor',[.9 .9 .9],'EdgeColor','black');
title('Boostrapped Estimated Median Histogram')
ylabel('Frequency'); xlabel('Estimated Median for each of the 100 runs')
