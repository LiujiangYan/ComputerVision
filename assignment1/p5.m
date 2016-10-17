function edge_image_out = p5(image_in)
    % using sobel as gradient operator
    sobelmatrix_x = [-1 0 1; -2 0 2; -1 0 1];
    sobelmatrix_y = [1 2 1; 0 0 0; -1 -2 -1];
    % convolute the input image matrix in x,y direction respectively
    edge_image_out_x = filter2(sobelmatrix_x, image_in);
    edge_image_out_y = filter2(sobelmatrix_y, image_in);
    % compute the overall magnitude of each pixel
    edge_image_out = sqrt(edge_image_out_x.^2 + edge_image_out_y.^2);
end