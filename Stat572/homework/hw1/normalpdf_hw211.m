function val = normalpdf_hw211( x,mu,var )
%Calculates normal pdf for a give x
% Exercise 2.11, Martinez
%   Detailed explanation goes here
val = -((2*pi*var)^(-1/2))*exp((1/2*var)*(x-mu)^2);

end

