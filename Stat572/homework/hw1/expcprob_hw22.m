%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates P(X<x) for an exponential pdf            %
% Exercise 2.1, Martinez                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function prob = expcprob_hw21(x,beta )
    function probout = expcout(x,beta)
        probout = (1./beta)*exp(-x./beta);
    end
quadgk(@(x)expcout(x,beta),0,x)
end

