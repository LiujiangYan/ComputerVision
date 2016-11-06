function [rows,cols] = detect_features(image)
    %%%
	% Computer Vision 600.461/661 Assignment 2
	% Args:
	% 	image (ndarray): The input image to detect features on. Note: this is NOT the image name or image path.
	% Returns:
	% 	rows: A list of row indices of detected feature locations in the image
    % 	cols: A list of col indices of detected feature locations in the image
	%%%
    
    image = rgb2gray(image);
    
    % robbert
    robbert_x = [0 1; -1 0];
    robbert_y = [1 0; 0 -1];  
    
    % calculate the derivative of both directions
    Ix = filter2(robbert_x, double(image));
    Iy = filter2(robbert_y, double(image));

    % construct 3*3 gaussian matirx
    h=fspecial('gaussian',[5 5],2);  
    
    % construct Ix^2 Iy^2 IxIy with gaussian filter
    Ix_square = filter2(h, (Ix.*Ix));
    Iy_square = filter2(h, (Iy.*Iy));
    Ix_Iy = filter2(h, (Ix.*Iy));  
    
    % calculate the R response matrix
    k = 0.06;
    R = Ix_square.*Iy_square-Ix_Iy.*Ix_Iy-k*(Ix_square+Iy_square).^2;
    
    threshold = quantile(R(:),0.99);
    
    % call the nonmaxsuppts to get the interest features
    [rows, cols] = nonmaxsuppts(R,2,threshold);
    
end

