function prob = lapCdf( x,lambda )
% This function calculates P(X<x) for a Laplacian distribution
% Exercise 2.4.b, Martinez
integral(@(x)lapDens(x,lambda),-Inf,x)
end