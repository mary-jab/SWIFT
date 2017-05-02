% estHypergeometric.m
% Description: This code is for SWIFT: Sparse Withdrawal of Inliers in
% a First Trial.
%
% Ref:
%  Jaberi, Maryam, Marianna Pensky, and Hassan Foroosh. "SWIFT: Sparse
%  Withdrawal of Inliers in a First Trial." Proceedings of the IEEE Conference
%  on Computer Vision and Pattern Recognition. 2015.
%
%   [prob] = estHypergeometric (N, theta, epsilon, r, mod)
%
%   Inputs:
%           N: population Size.
%           theta: Minimum size of a valid structure.
%           epsilon: Degrees of freedom of a valid structure.
%           r: the minimum required number of points to be sampled
%           mod:  'hyperGeoApp'     formula (6a) in the paper
%                 'hyperGeoExact'   formula (6) in the paper
%                 'exp'             formula (6a) in the paper
%
%
%   Outputs:
%           prob: probably of selection epsilon point in each structure
%
%
% Copyright by Maryam Jaberi
% Date: Sep. 30, 2016
% Revised by: Nov. 10, 2016


function [prob] = estHypergeometric (N, theta, epsilon, r, mod)
C = ceil(N/theta);
d = ceil(r/C);
%% intialize
sumP = 0;
if strcmpi(mod, 'hyperGeoApp')
    %% for each class
    for k=0:epsilon -1
        sumP = sumP + nchoosek(C*d,k) * (1/((C-1)))^k;
    end
    delta = P_0 * sumP;
elseif strcmpi(mod, 'hyperGeoExact')
    P_0 =1;
    for j=0:theta-1
        P_0 =  P_0 * ((C*theta-C*d-j)/(C*theta-j));
    end
    for k=0:epsilon -1
        coef = evalin(symengine, ['nchoosek(' num2str(C*d) ',' num2str(k) ')']);
        sumP = sumP + double(coef) * (1/((C-1)))^k;
    end
    delta = P_0 * sumP;
elseif strcmpi(mod, 'exp')
    P_0 = exp(-d);
    for k=0:epsilon -1
        sumP = sumP + nchoosek(C*d,k) * (1/((C-1)))^k;
    end
    delta = P_0 * sumP;
end
prob = 1 - C * delta;
end



