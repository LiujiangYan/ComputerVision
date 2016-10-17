clear;
clc;
format compact;

image_in_1 = imread('hough_simple_1.pgm');
image_in_2 = imread('hough_simple_2.pgm');
image_in_3 = imread('hough_complex_1.pgm');
edge_image_out_1 = p5(image_in_1);
edge_image_out_2 = p5(image_in_2);
edge_image_out_3 = p5(image_in_3);
% uncomment the following lines to display the results of p5
% subplot(2,3,1);
% imagesc(image_in_1);
% subplot(2,3,2);
% imagesc(image_in_2);
% subplot(2,3,3);
% imagesc(image_in_3);
% subplot(2,3,4);
% imagesc(edge_image_out_1);
% subplot(2,3,5);
% imagesc(edge_image_out_2);
% subplot(2,3,6);
% imagesc(edge_image_out_3);

[edge_image_thresh_out_1, hough_image_out_1] = p6(edge_image_out_1, 100);
[edge_image_thresh_out_2, hough_image_out_2] = p6(edge_image_out_2, 50);
[edge_image_thresh_out_3, hough_image_out_3] = p6(edge_image_out_3, 100);
% uncomment the following lines to display the results of p5
% subplot(3,3,1);
% imagesc(edge_image_out_1);
% subplot(3,3,2);
% imagesc(edge_image_out_2);
% subplot(3,3,3);
% imagesc(edge_image_out_3);
% subplot(3,3,4);
% imagesc(edge_image_thresh_out_1);
% subplot(3,3,5);
% imagesc(edge_image_thresh_out_2);
% subplot(3,3,6);
% imagesc(edge_image_thresh_out_3);
% subplot(3,3,7);
% imagesc(hough_image_out_1);
% subplot(3,3,8);
% imagesc(hough_image_out_2);
% subplot(3,3,9);
% imagesc(hough_image_out_3);

% uncomment the following lines to display the results of p7
% subplot(1,3,1);
% line_image_out_1 = p7(image_in_1, hough_image_out_1, 125);
% subplot(1,3,2);
% line_image_out_2 = p7(image_in_2, hough_image_out_2, 90);
% subplot(1,3,3);
% line_image_out_3 = p7(image_in_3, hough_image_out_3, 100);
 
% uncomment the following lines to display the results of p8
% subplot(1,3,1);
% cropped_lines_image_out_1 = p8(image_in_1, hough_image_out_1, edge_image_thresh_out_1, 125);
% subplot(1,3,2);
% cropped_lines_image_out_2 = p8(image_in_2, hough_image_out_2, edge_image_thresh_out_2, 100);
% subplot(1,3,3);
% cropped_lines_image_out_3 = p8(image_in_3, hough_image_out_3, edge_image_thresh_out_3, 130);