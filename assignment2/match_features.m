function [ matches ] = match_features(feature_coords1,feature_coords2,...
                                        image1,image2)
    %%% 
	% Computer Vision 600.461/661 Assignment 2
	% Args:
	%	feature_coords1 : list of (row,col) feature coordinates from image1
	%	feature_coords2 : list of (row,col)feature coordinates from image2
	% 	image1 : The input image corresponding to features_coords1
	% 	image2 : The input image corresponding to features_coords2
	% Returns:
	% 	matches : list of index pairs of possible matches. For example, if the 4-th feature in feature_coords1 and the 1-st feature
	%							  in feature_coords2 are determined to be matches, the list should contain (4,1).
	%%%
    
    image1_gray = rgb2gray(image1);
    image2_gray = rgb2gray(image2);

    matches = [];
    % predefine the ncc with the size
    ssd = inf(length(feature_coords1), length(feature_coords2));
    
    % boundary
    [h1, w1,~] = size(image1);
    [h2, w2,~] = size(image2);
    
    % patch size
    side = 10;
    patch = (2*side+1)^2;
    
    % loop feature_coords of first image and second image
    for i=1:length(feature_coords1)
        x1 = feature_coords1(i,1);
        y1 = feature_coords1(i,2);
        if x1 > 10 && x1 < h1-10 && y1 > 10 && y1 < w1-10
            vector_1 = double(reshape(image1_gray(x1-side:x1+side,...
                y1-side:y1+side),patch,1));

            for j=1:length(feature_coords2)
                x2 = feature_coords2(j,1);
                y2 = feature_coords2(j,2);
                if x2 > 10 && x2 < h2-10 && y2 > 10 && y2 < w2-10
                    vector_2 = double(reshape(image2_gray(x2-side:x2+side,...
                        y2-side:y2+side),patch,1));
                    
                    ssd(i,j) = norm(vector_1 - vector_2)...
                        /norm(vector_1)/norm(vector_2);
                end
            end
        end
    end
        
    matches = [];
    % loop the line
    for i=1:length(feature_coords1)
        % get the index of maximum ncc of i row, store as label_2
        [~,label_2] = min(ssd(i,:));
        % get the index of maximum ncc of label_2, store as label_1
        [~,label_1] = min(ssd(:,label_2));
        % if label_1 and i are equal, then it is a good match, store.
        if label_1 == i
            matches = [matches; [label_1, label_2]];
        end
    end
    
    %display matches
    display_matched(image1, image2,...
        feature_coords1, feature_coords2, matches);
    
end

