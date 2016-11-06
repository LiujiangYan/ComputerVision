clc;
clear;
format compact;

% read the left and right image
image_left = imread('HW3_images/scene_l.bmp');
image_right = imread('HW3_images/scene_r.bmp');

% given parameters
focal_length = 400;
baseline = 100;

% size of iamge
[height, width] = size(image_left);

% compute the depth map
depth_map = compute_depth_map...
    (image_left, image_right, focal_length, baseline, 'ncc');
csvwrite('depth_map.csv', depth_map);

% compute the x,y,z coordinates
index = 0;
for v_l=1+7:height-7
    for u_l=1+7:width-7
        index = index + 1;
        stereo_xyz(index,:) = [depth_map(v_l,u_l)*u_l/focal_length,...
                               depth_map(v_l,u_l)*v_l/focal_length,...
                               depth_map(v_l,u_l)];
    end
end
csv('stero_xyz.csv', stereo_xyz);
