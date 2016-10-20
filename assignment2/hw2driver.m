clear
clc
format compact
addpath('rawimage');
% uncomment the image reading command and change the image name
% the value following each pair are for detect features threshold
% bikes1 - bikes2 0.99
% bikes1 - bikes3 0.99
img_1 = imread('bikes3.png');
img_2 = imread('bikes1.png');
% graf1 - graf2 0.9
% graf1 - graf3 0.3
% img_1 = imread('graf3.png');
% img_2 = imread('graf1.png');
% leuven1 - leuven2 0.95a
% leuven1 - leuven3 0.85
% img_1 = imread('leuven2.png');
% img_2 = imread('leuven1.png');
% wall1 - wall2 0.99
% wall1 - wall3 0.9
% img_1 = imread('wall3.png');
% img_2 = imread('wall1.png');

[rows,cols] = detect_features(img_1); feature_coords1 = [rows,cols];
[rows,cols] = detect_features(img_2); feature_coords2 = [rows,cols];

% matches = match_features(feature_coords1,feature_coords2,img_1,img_2);
% affine_xform = compute_affine_xform(matches,feature_coords1,...
%                                         feature_coords2,img_1,img_2);
% proj_xform = compute_proj_xform(matches,...
%                             feature_coords1,feature_coords2,img_1,img_2);

% uncomment the following commands for sift descriptor, matches and affine
descriptors_1 = ssift_descriptor(feature_coords1,img_1);
descriptors_2 = ssift_descriptor(feature_coords2,img_2);

% the values following each pair are the threshold for ratio test
% bikes1 - bikes2 0.6
% bikes1 - bikes3 0.6
% graf1 - graf2 0.85
% graf1 - graf3 0.95
% leuven1 - leuven2 0.6
% leuven1 - leuven3 0.6
% wall1 - wall2 0.7
% wall1 - wall3 0.95

matches_sift = matches_ratio_test(descriptors_1, descriptors_2);
affine_xform = compute_affine_xform(matches_sift,feature_coords1,...
                                        feature_coords2,img_1,img_2);