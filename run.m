% Population size
N = 10000;
% Number of classes
C = 20;
% Degrees of freedom
epsilon = 3;
% Selection accuracy
P = .9;

theta = floor(N/C);
[est_r] = SWIFT (N, theta, epsilon, P);
