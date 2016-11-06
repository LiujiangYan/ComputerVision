function sad = compute_sad(left_window, right_window, window_side)
    window_size = window_side^2;
    left_window = reshape(left_window, window_size, 1);
    right_window = reshape(right_window, window_size, 1);
    sad = sum(abs(left_window-right_window));
end