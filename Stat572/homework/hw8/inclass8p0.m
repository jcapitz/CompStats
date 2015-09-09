% generate gamma(3,2) rs
x = gamrnd(3,2,1,1000);
xroot = sqrt(x);
expected_x = mean(xroot);