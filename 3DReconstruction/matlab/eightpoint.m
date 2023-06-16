function F = eightpoint(pts1, pts2, M)
    % eightpoint:
    %   pts1 - Nx2 matrix of (x,y) coordinates
    %   pts2 - Nx2 matrix of (x,y) coordinates
    %   M    - max (imwidth, imheight)

    % Normalize the points
    normalizedPts1 = pts1 / M;
    normalizedPts2 = pts2 / M;

    % Build the matrix A from the normalized point pairs
    A = [normalizedPts2(:, 1) .* normalizedPts1, normalizedPts2(:, 1), ...
         normalizedPts2(:, 2) .* normalizedPts1, normalizedPts2(:, 2), ...
         normalizedPts1, ones(size(pts1, 1), 1)];

    % Perform SVD on matrix A
    [~, ~, V] = svd(A);

    % Construct the fundamental matrix F from the last column of V
    F_normalized = reshape(V(:, end), 3, 3);

    % Enforce the rank-2 constraint on F
    [U, S, V] = svd(F_normalized);
    S(3, 3) = 0;
    F_normalized = U * S * V';

    % Denormalize F
    denormalizeMatrix = [1/M, 0, 0; 0, 1/M, 0; 0, 0, 1];
    F = denormalizeMatrix' * F_normalized * denormalizeMatrix;
end