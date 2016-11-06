function ncc = compute_ncc(left_window, right_window, half_window_side)
    % compute the number of pixels in the window
    window_size = (half_window_side*2 + 1)^2;
    
    % construct it as a vector
    left_window = single(reshape(left_window, window_size, 1));
    right_window = single(reshape(right_window, window_size, 1));
    
    % compute ncc by definition
    ncc = dot(left_window,right_window)/...
        norm(left_window)/norm(right_window);

end