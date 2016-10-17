function binary_out = p1(gray_in, thresh_val)
    % create the output of exact size as input
    binary_out = zeros(size(gray_in));
    % find the index of pixels with value over the thresh_val
    index = (gray_in > thresh_val);
    % assign 1 to those pixels
    binary_out(index) = 1;
    % assign 0 to others
    binary_out(~index) = 0;
end