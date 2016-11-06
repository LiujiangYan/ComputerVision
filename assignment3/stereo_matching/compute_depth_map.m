function depth_map = compute_depth_map...
    (image_left, image_right, focal_length, baseline)
    % get the image size
    [h_left, w_left] = size(image_left);
    [h_right, w_right] = size(image_right);
    
    depth_map = zeros(h_right, w_right);
    half_window_side = 7;
    
    % ignore border
    for h_l=(1+half_window_side):(h_left-half_window_side)
        for w_l=(1+half_window_side):(w_left-half_window_side)
            
            % loop the 15*15 window around the left image
            left_window = image_left(...
                h_l-half_window_side:h_l+half_window_side,...
                w_l-half_window_side:w_l+half_window_side);
            
            % construct ncc vector for each pixel in the same y of right image
            ncc = zeros(1, w_right);
            
            % loop each window of same y
            h_r = h_l;
            for w_r=(1+half_window_side):(w_right-half_window_side)
                    
                right_window = image_right(...
                    h_r-half_window_side:h_r+half_window_side, ...
                    w_r-half_window_side:w_r+half_window_side);

                % compute ncc for each window
                ncc(w_r) = compute_ncc(left_window, right_window, half_window_side);
                    
            end
            
            % get the index 
            [~, u_r] = max(ncc);
            u_l = w_l;
            depth_map(h_l, w_l) = baseline*focal_length/(u_l-u_r);
        end
    end
end