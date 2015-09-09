function [bc, fhath] = histDensEst(data)
% Histogram estimate of the PDF
% Use Normal Reference Rule for bin width
% of frequency histogram.
n = length(data);
h = 2.15*sqrt(var(data))*n^(-1/5);
t0 = min(data)-0.5;
tm = max(data)+0.5;
bins = t0:h:tm;
vk = histc(data,bins);
vk(end) = [];
fhath = vk/(n*h);
bc = (t0+h/2):h:(tm-h/2);

% Plotting
bar(bc,fhath,1,'w')