function output = stitch(image1, image2, affine_xform)
    % get the size of each image
    [h1, w1, ~] = size(image1);
    [h2, w2, ~] = size(image2);
    
    % affine_image*image1 = image2
    % get the affined position of each pixel of image 1
    affine_position = zeros(h1, w1, 2);
    for h=1:h1
        for w=1:w1
            position_homo = affine_xform*[h;w;1];
            affine_position(h,w,:) = position_homo(1:2);
        end
    end
    
    % get the maximum/minimum x y position
    affine_position_h_max = ceil(max(max(affine_position(:,:,1))));
    affine_position_h_min = floor(min(min(affine_position(:,:,1))));
    
    affine_position_w_max = ceil(max(max(affine_position(:,:,2))));
    affine_position_w_min = floor(min(min(affine_position(:,:,2))));
    
    % get the range of the stitched image
    range_h = range([1,h2,affine_position_h_min,affine_position_h_max])+1;
    range_w = range([1,w2,affine_position_w_max,affine_position_w_min])+1;
    
    % define the displacement
    dh = abs(affine_position_h_min) + 1;
    dw = abs(affine_position_w_min) + 1;
    
    % resize image 1 to the affined postion of the output image size
    img1_resized = zeros(range_h + dh, range_w + dw, 3);    
    for h=1:h1
        for w=1:w1
            i = round(affine_position(h,w,1)+dh);
            j = round(affine_position(h,w,2)+dw);
            img1_resized(i,j) = image1(h,w);
        end
    end
    
    % displace image 2 to the output image size
    img2_resized = zeros(range_h + dh, range_w + dw, 3);    
    img2_resized(1+dh:h2+dh,1+dw:w2+dw,:) = image2;
    
    % stitch together
    output = (img1_resized + img2_resized)/2;
    imshow(uint8(output));
    
    % or you can just show both by calling the following commands
    % img1 = imshow(uint8(img1_resized));
    % set(img1, 'AlphaData', 0.5);
    % hold on;
    % img2 = imshow(uint8(img2_resized));
    % set(img2, 'AlphaData', 0.5);
end