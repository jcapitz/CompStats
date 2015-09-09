function X= SD(x)
X= zeros(1, length(x) );

for i= 1:length(x)
if x(i) == 0
X(i)= 1/( 2*sqrt(2*pi) );
elseif x(i) ~= 0
X(i)= ( 1 - exp( (-x(i)^2)/2 ) ) / ( ( x(i)^2)*sqrt(2*pi) ) ;
end
end

end

