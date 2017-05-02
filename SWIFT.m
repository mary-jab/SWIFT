
% SWIFT.m
% Description: This code is for SWIFT: Sparse Withdrawal of Inliers in
% a First Trial.
%
% Ref:
%  Jaberi, Maryam, Marianna Pensky, and Hassan Foroosh. "SWIFT: Sparse
%  Withdrawal of Inliers in a First Trial." Proceedings of the IEEE Conference
%  on Computer Vision and Pattern Recognition. 2015.
%
%   [r,calcP] = SWIFT (N, theta, epsilon, prob)
%
%    Inputs:
%           N: population Size.
%           theta: Minimum size of a valid structure.
%           epsilon: Degrees of freedom of a valid structure.
%           prob: accuracy of computing sample size
%
%   Outputs:
%           r: the minimum number of points to be sampled randomly from a population N in one grab, in order to make sure with probability P that there are at least “epsilon” samples on each structure
%           calcP: actual probably of having epsilon point in each structure
%
%
% Copyright by Maryam Jaberi
% Date: Sep. 30, 2016
% Revised by: Nov. 10, 2016



function [r,calcP] = SWIFT (N, theta, epsilon, prob)
% Calculate basic parameters
C = ceil( N/theta);
rMin = epsilon* C;
rMax = N;
r = N;
%  Divide and conquer searching
calcP = 0;
while (rMin<(rMax-1) )
    r = round((rMin+rMax)/2);
    [calcP] = estHypergeometric (N, theta, epsilon, r, 'hyperGeoExact');
    if calcP < prob
        rMin = r;
    else
        rMax = r;
    end
end
end
