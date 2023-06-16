function P = estimate_pose(x, X)
P = zeros(3,4);
[~, N] = size(X);
A = zeros(2*N, 12);
for i = 1:N
    Xi = X(1, i); 
    Yi = X(2, i); 
    Zi = X(3, i);
    xi = x(1, i); 
    yi = x(2, i);
    A(2*i-1, :) = [-Xi, -Yi, -Zi, -1, 0, 0, 0, 0, xi*Xi, xi*Yi, xi*Zi, xi];
    A(2*i, :) = [0, 0, 0, 0, -Xi, -Yi, -Zi, -1, yi*Xi, yi*Yi, yi*Zi, yi];
end
[~, ~, V] = svd(A);
P = reshape(V(:, end), [4 3])';
end