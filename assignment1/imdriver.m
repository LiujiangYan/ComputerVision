gray_in = imread('two_objects.pgm');

thresh_val = 80;
binary_out = p1(gray_in, thresh_val);
% imagesc(binary_out);

labels_out = p2(binary_out);
% imagesc(labels_out);

[database_out, overlays_out] = p3(labels_out);
% imagesc(overlays_out);

gray_in_manyobject_1 = imread('many_objects_1.pgm');
thresh_val_manyobejct_1 = 100;
binary_out_manyobject_1 = p1(gray_in_manyobject_1, thresh_val_manyobejct_1);
% imagesc(binary_out_manyobject_1);
labels_out_manyobject_1 = p2(binary_out_manyobject_1);
% imagesc(labels_out_manyobject_1);
[database_out, overlays_out] = p3(labels_out_manyobject_1);
% imagesc(overlays_out);

% overlays_out_compare_1 = p4(labels_out_manyobject_1, database_out);
% imagesc(overlays_out_compare_1);

gray_in_manyobject_2 = imread('many_objects_2.pgm');
thresh_val_manyobejct_2 = 100;
binary_out_manyobject_2 = p1(gray_in_manyobject_2, thresh_val_manyobejct_2);
% imagesc(binary_out_manyobject_2);
labels_out_manyobject_2 = p2(binary_out_manyobject_2);
% imagesc(labels_out_manyobject_2);
[database_out, overlays_out] = p3(labels_out_manyobject_2);
imagesc(overlays_out);

% overlays_out_compare_2 = p4(labels_out_manyobject_2, database_out);
% imagesc(overlays_out_compare_2);
