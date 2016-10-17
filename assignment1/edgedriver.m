clear
clc
image_in = imread('hough_simple_1.pgm');
edge_image_out = p5(image_in);
% imagesc(edge_image_out);

edge_thresh = 50;
[edge_image_thresh_out, hough_image_out] = p6(edge_image_out, edge_thresh);
% imagesc(edge_image_thresh_out);
% imagesc(hough_image_out);

hough_thresh = 125;
line_image_out = p7(image_in, hough_image_out, hough_thresh);
% cropped_lines_image_out = p8(image_in, hough_image_out, edge_image_thresh_out, hough_thresh);

% image_in = imread('hough_simple_2.pgm');
% edge_image_out = p5(image_in);
% imagesc(edge_image_out);

% edge_thresh = 50;
% [edge_image_thresh_out, hough_image_out] = p6(edge_image_out, edge_thresh);
% imagesc(edge_image_thresh_out);
% imagesc(hough_image_out);
% 
% hough_thresh = 100;
% line_image_out = p7(image_in, hough_image_out, hough_thresh);
% cropped_lines_image_out = p8(image_in, hough_image_out, edge_image_thresh_out, hough_thresh);
% 

% image_in = imread('hough_complex_1.pgm');
% edge_image_out = p5(image_in);
% imagesc(edge_image_out);
% 
% edge_thresh = 150;
% [edge_image_thresh_out, hough_image_out] = p6(edge_image_out, edge_thresh);
% imagesc(edge_image_thresh_out);
% imagesc(hough_image_out);
% 
% hough_thresh = 100;
% line_image_out = p7(image_in, hough_image_out, hough_thresh);
% cropped_lines_image_out = p8(image_in, hough_image_out, edge_image_thresh_out, hough_thresh);
% 
