clear;
clc;
format compact;

gray_in_1 = imread('two_objects.pgm');
gray_in_2 = imread('many_objects_1.pgm');
gray_in_3 = imread('many_objects_2.pgm');

binary_out_1 = p1(gray_in_1, 150);
binary_out_2 = p1(gray_in_2, 150);
binary_out_3 = p1(gray_in_3, 150);
% uncomment the following lines to display the results of p1
% subplot(2,3,1);
% imagesc(gray_in_1);
% subplot(2,3,2);
% imagesc(gray_in_2);
% subplot(2,3,3);
% imagesc(gray_in_3);
% subplot(2,3,4);
% imagesc(binary_out_1);
% subplot(2,3,5);
% imagesc(binary_out_2);
% subplot(2,3,6);
% imagesc(binary_out_3);

% uncomment the following lines to display the results of p2
labels_out_1 = p2(binary_out_1);
labels_out_2 = p2(binary_out_2);
labels_out_3 = p2(binary_out_3);
% subplot(2,3,1);
% imagesc(binary_out_1);
% subplot(2,3,2);
% imagesc(binary_out_2);
% subplot(2,3,3);
% imagesc(binary_out_3);
% subplot(2,3,4);
% imagesc(labels_out_1);
% subplot(2,3,5);
% imagesc(labels_out_2);
% subplot(2,3,6);
% imagesc(labels_out_3);

[database_out_1, overlays_out_1] = p3(labels_out_1);
[database_out_2, overlays_out_2] = p3(labels_out_2);
[database_out_3, overlays_out_3] = p3(labels_out_3);
% uncomment the following lines to display the results of p3
% subplot(2,3,1);
% imagesc(labels_out_1);
% subplot(2,3,2);
% imagesc(labels_out_2);
% subplot(2,3,3);
% imagesc(labels_out_3);
% subplot(2,3,4);
% imagesc(overlays_out_1);
% subplot(2,3,5);
% imagesc(overlays_out_2);
% subplot(2,3,6);
% imagesc(overlays_out_3);

overlays_out_compare_1 = p4(labels_out_2, database_out_1);
overlays_out_compare_2 = p4(labels_out_3, database_out_1);
% uncomment the following lines to display the results of p4
subplot(2,3,1);
imagesc(labels_out_2);
subplot(2,3,2);
imagesc(labels_out_1);
subplot(2,3,3);
imagesc(overlays_out_compare_1);
subplot(2,3,4);
imagesc(labels_out_3);
subplot(2,3,5);
imagesc(labels_out_1);
subplot(2,3,6);
imagesc(overlays_out_compare_2);