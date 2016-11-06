function F = compute_fundamental_matrix...
    (feature_coordinate_left, feature_coordinate_right, matches)
    % solve for Af=0
    A = [];
    for i=1:size(matches,1)
        % get ul,vl,ur,vr respectively
        ul = feature_coordinate_left(matches(i,1),1);
        vl = feature_coordinate_left(matches(i,1),2);
        ur = feature_coordinate_right(matches(i,2),1);
        vr = feature_coordinate_right(matches(i,2),2);
        % construct each row of A
        subA = [ul*ur, vl*ur, ur, ul*vr, vl*vr, vr, ul, vl, 1];
        A = [A; subA];
    end
    % get the eigenvalue and eigenvector of ATA
    [V, D] = eig(A'*A);
    
    % find the index of smallest eigenvalue
    D(D==0) = inf;
    [~, index] = min(D(:));
    % get the corresponding eigenvector
    f = V(:,index);
    % reshape to 3 by 3 matrix form
    F = reshape(f, 3, 3);
end
