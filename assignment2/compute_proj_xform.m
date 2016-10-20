function proj_xform = compute_proj_xform(matches,features1,features2,...
                                            image1,image2)  
    % predefine some vectors for following storing
    x1 = zeros(4,1); y1 = zeros(4,1); 
    x2 = zeros(4,1); y2 = zeros(4,1);
    
    % let's take N times to get the best projective matrix
    N = 5000;
    
    % record the final matrix
    proj_xform = zeros(3,3);
    
    % record the inlier with a label in third column of matches
    matches_mark = matches;
    matches_mark(:,3) = 0;
    
    for i=1:N
        matches_mark_cur = matches_mark;
        matches_mark_cur(:,3) = 0;
        % clear A
        A = [];
        
        % get the index of pairs for following valuing
        trail = randsample(length(matches), 4);
        
        for j=1:4
            % from the index get the points accordingly
            x1(j) = features1(matches(trail(j),1),1); 
            y1(j) = features1(matches(trail(j),1),2); 
            x2(j) = features2(matches(trail(j),2),1);
            y2(j) = features2(matches(trail(j),2),2);
            
            % construct A
            subA = [x1(j) y1(j) 1 0 0 0 -x2(j)*x1(j) -x2(j)*y1(j) -x2(j); ...
                     0 0 0 x1(j) y1(j) 1 -y2(j)*x1(j) -y2(j)*y1(j) -y2(j)];
            A = [A; subA];
        end
        
        % get the square matrix A^TA for eigenvector computing
        ATA = A'*A;
        [V,D] =  eig(ATA);
        
        % get the index of minimum eigenvalue
        % the corresponding eigenvector is just h
        D(D==0)=inf;
        [~,index] = min(min(D));
        h = V(:,index);
        
        % assign the elements of h for correction
        h = reshape(h,3,3)';
        
        % loop the points pairs to get the inliers for this h
        for n=1:length(matches)
            feature = [features1(matches(n,1),:),1]';
            feature_mapped = [features2(matches(n,2),:),1]';
            feature_calculated = h*feature;
            feature_calculated = feature_calculated/feature_calculated(3);
            
            % if the difference in both direction are less that 5 pixels
            % consider it inlier
            if norm(feature_calculated-feature_mapped)<10
                matches_mark_cur(n,3) = 1;
            end
        end
        
        % if the current count is larger than past record
        % update inlier and pass current t to our record        
        if sum(matches_mark_cur(:,3)) > sum(matches_mark(:,3))
            proj_xform = h;
            matches_mark = matches_mark_cur;
        end
    end
    
    % normalize the last element of transformation matrix
    proj_xform = proj_xform/proj_xform(3,3);
    
    % display the matches
    display_matched(image1, image2, features1, features2, matches_mark)
    figure
    % display the stitched image
    stitch(image1,image2,proj_xform);
end