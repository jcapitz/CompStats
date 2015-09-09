function density = lapDens( x,lambda )
% This function evaluates the Laplacian density for a given x
% Exercise 2.4, Martinez
    density = (1/2)*lambda*exp(-lambda*abs(x));
end

