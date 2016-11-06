function ssd = compute_ssd(left_window, right_window, half_window_side)
    window_size = (half_window_side*2 + 1)^2;
    
    left_window = reshape(left_window, window_size, 1);
    right_window = reshape(right_window, window_size, 1);
    
    ssd = sum((left_window-right_window).^2);
end