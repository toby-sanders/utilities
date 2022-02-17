function [tau,out] = getStepLength(A,n)

% simple power iteration for computing the maximum eigenvalue, lambda, of 
% the matrix A^T * A, from the given input matrix A

% I wrote this to get a useful step length for a simple gradient descent
% algorithm, so the return from the function is the maximum step length,
% tau

% Generally speaking, the estimate for lambda is increasing with each
% iteration (it may be gauranteed monotone but I'm not sure), so stopping
% the iterations earlier will under estimate lambda, hence over-estimating
% tau. In this case the user should scale the output tau to ensure
% convergence, e.g. newTau = tau/2;

% written by Toby Sanders @Lickenbrock Tech.
% 2/25/2021

if ~isa(A,'function_handle'), A = @(u,mode) f_handleA(A,u,mode); end

x = randn(n,1); % random vector for the power iterations

% some hard-coded parameter
iter = 50; % maximum iterations
tol = 1e-3; % tolerance to break

% run power iterations
lambda = 0;
out.rel_chg = zeros(iter,1);
out.lambda = zeros(iter,1);
for i = 1:iter
    
    % store old x and compute A^T*A*x
    xp = x/sqrt(x'*x); % normalize in the process
    x = A(xp,1);
    x = A(x,2);
    
    % estimate new eigenvalue bases on ratio of the last two vectors
    lambdap = lambda;
    lambda = sqrt(x'*x); % xp was normalized, ||xp||=1
    
    % check convergence
    out.rel_chg(i) = abs(lambda-lambdap)/abs(lambda);
    out.lambda(i) = lambda;
    if out.rel_chg(i)<tol, break; end
    
end
out.rel_chg = out.rel_chg(1:i);
out.lambda = out.lambda(1:i);
tau = 1/lambda;