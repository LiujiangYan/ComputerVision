function [edge_image_thresh_out, hough_image_out] = ...
    p6(edge_image_in, edge_thresh)
    
    % get the index of pixels with value over the threshold
    % assign the index with value 1 and others with 0
    index = (edge_image_in >= edge_thresh);
    edge_image_thresh_out = zeros(size(edge_image_in));
    edge_image_thresh_out(index) = 1;
    
    % the rho_max is the length of diagonal
    rho_max = sqrt(length(edge_image_thresh_out(1,:))^2+...
        length(edge_image_thresh_out(:,1))^2);
    % discrete the parameter
    theta_number = 360;
    rho_number = 1000;
    hough_image_out = zeros(theta_number, rho_number);
    
    % loop the pixels
    for x=1:length(edge_image_thresh_out(:,1))
        for y=1:length(edge_image_thresh_out(1,:))
            % if the pixel is in the edge
            if edge_image_thresh_out(x,y) == 1
                % loop the theta from -pi/2 to pi/2
                for i=1:theta_number
                    theta = pi/theta_number*i-pi/2;
                    % compute the corresponding rho
                    rho = y*cos(theta)-x*sin(theta);
                    j = ceil((rho+rho_max)/(2*rho_max)*rho_number);
                    hough_image_out(i,j) = hough_image_out(i,j)+1;
                end
            end
        end
    end
    
    % scale the hough matrix with values between 0 and 255
    hough_image_out = hough_image_out.*(255/max(hough_image_out(:)));
end