function [U,coef] = myGramSchmidt(V)

% perform  the Gram-Schmidt orthonormalization of the columns of the matrix
% V and store the result into U. Also, compute the coefficients of V in the
% expansion of the ONB, U


[N,dim] = size(V);
U = zeros(N,dim);
for i = 1:dim
    U(:,i) = V(:,i);
    for j = 1:i-1 
        % for each element already formed in our basis, subtract the
        % projection of current element onto former element
        U(:,i) = U(:,i) - sum(U(:,j).*V(:,i))*U(:,j);
    end
    U(:,i) = U(:,i)/norm(U(:,i)); % make unitary!
end

% coefficients for representation of V in terms of our ONB, U
coef = U'*V;