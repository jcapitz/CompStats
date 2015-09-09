lam = 1; l = 5; n = 1000; k = 100;
Z = poissonRandom(lam,2,k,n);
categories = 1:1:11;
Count_2 = histc(Z,categories);

Z = poissonRandom(lam,4,k,n);
categories = 1:1:11;
Count_4 = histc(Z,categories);

Z = poissonRandom(lam,8,k,n);
categories = 1:1:11;
Count_8 = histc(Z,categories);

Z = poissonRandom(lam,16,k,n);
categories = 1:1:11;
Count_16 = histc(Z,categories);

catlbl = {'0 to 1','1 to 2','2 to 3','3 to 4','4 to 5','5 to 6',...
    '6 to 7','7 to 8','8 to 9','9 to 10','10 +'};
T = table(Count_2,Count_4,Count_8,Count_16,'RowNames',catlbl);

