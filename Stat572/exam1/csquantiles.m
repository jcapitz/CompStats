function qhat = csquantiles(x,p)
if ~isempty(find(p <= 0 | p >1))
error('Probabilities must be between 0 and 1')
return
end
xs=sort(x);
qhat = zeros(size(p));
n=length(x);
phat = ((1:n)-0.5)/n;
qhat=interp1(phat,xs,p);