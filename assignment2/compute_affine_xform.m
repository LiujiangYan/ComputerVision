function [affine_xform] = compute_affine_xform(matches,features1,features2,...
                                                image1,image2)
	%%%
	% Computer Vision 600.461/661 Assignment 2
	% Args:
	%	matches : list of index pairs of possible matches. For example, if the 4-th feature in feature_coords1 and the 1-st feature
	%							  in feature_coords2 are determined to be matches, the list should contain (4,1).
    %   features1 (list of tuples) : list of feature coordinates corresponding to image1
    %   features2 (list of tuples) : list of feature coordinates corresponding to image2
	% 	image1 : The input image corresponding to features_coords1
	% 	image2 : The input image corresponding to features_coords2
	% Returns:
	%	affine_xform (ndarray): a 3x3 Affine transformation matrix between the two images, computed using the matches.
	% 
    
    % predefine some matrix for following storing
    x1 = zeros(1,3); y1 = zeros(1,3); x2 = zeros(1,3); y2 = zeros(1,3);
    
    % let's take N times to get the best affine matrix
    N = 5000;
 
    % record the inlier with a label in third column of matches    
    matches_mark = matches;
    matches_mark(:,3) = 0;
    
    for i=1:N
        % initialize the current mark matrix
        matches_mark_cur = matches_mark;
        matches_mark_cur(:,3) = 0;
        
        % get a random combination of 3 pairs out of n matching pairs
        trail = randsample(length(matches), 3);
        
        for j=1:3
            % from the index get the points accordingly
            x1(j) = features1(matches(trail(j),1),1);
            y1(j) = features1(matches(trail(j),1),2); 
            x2(j) = features2(matches(trail(j),2),1);
            y2(j) = features2(matches(trail(j),2),2);
        end
        % Let Ra=b, where R stands for the transformation matirx
        % in homogeneous representation        
        a = [x1;y1;1 1 1];
        b = [x2;y2;1 1 1];
        
        % get the parameter vector t by direct calculation
        t = b/a;

        % count the inlier for each trial
        count = 0;
        % loop the points pairs in matches
        % compare the real point to mapped point
        for n=1:length(matches)
            feature = [features1(matches(n,1),:), 1]';
            feature_mapped = [features2(matches(n,2),:), 1]';
            feature_calculated = t*feature;
            
            % if the difference of the norm of vector difference is less than 10
            if norm(feature_calculated-feature_mapped)<10
                count = count + 1;
                matches_mark_cur(n,3) = 1;
            end
        end
        
        % if the current count is larger than past record
        % update inlier and pass current t to our record
        if sum(matches_mark_cur(:,3)) > sum(matches_mark(:,3))
            affine_xform = t;
            matches_mark = matches_mark_cur;
        end
    end
    
    % display the matches
    display_matched(image1, image2, features1, features2, matches_mark)
    figure
    % display the stitched image
    stitch(image1,image2,affine_xform);
end