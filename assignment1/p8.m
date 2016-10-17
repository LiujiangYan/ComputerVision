function cropped_lines_image_out = p8(image_in, hough_image_in, edge_thresholded_in, hough_thresh)

    cropped_lines_image_out = [];
    rho_max = sqrt(length(edge_thresholded_in(1,:))^2 + ...
        length(edge_thresholded_in(:,1))^2);
    theta_number = 360;
    rho_number = 1000;
    
    hough_image_out = zeros(theta_number, rho_number);
    
    % four matrix of same size as hough matrix to record endpoints postion
    endpoint_max_x = -inf*ones(theta_number, rho_number);
    endpoint_max_y = zeros(theta_number, rho_number);
    endpoint_min_x = inf*ones(theta_number, rho_number);
    endpoint_min_y = zeros(theta_number, rho_number);
    
    % loop the pixels
    for x=1:length(edge_thresholded_in(:,1))
        for y=1:length(edge_thresholded_in(1,:))
            % if the pixel is in the edge
            if edge_thresholded_in(x,y) == 1
                % loop the theta from -pi/2 to pi/2
                for i=1:theta_number
                    theta = pi/theta_number*i-pi/2;
                    % compute the corresponding rho
                    rho = y*cos(theta)-x*sin(theta);
                    j = ceil((rho+rho_max)/(2*rho_max)*rho_number);
                    hough_image_out(i,j) = hough_image_out(i,j)+1;
                    % record the maximum or minimum x value
                    % and corresponding endpoints
                    if x > endpoint_max_x(i,j)
                        endpoint_max_x(i,j) = x;
                        endpoint_max_y(i,j) = y;
                    elseif x < endpoint_min_x(i,j)
                        endpoint_min_x(i,j) = x;
                        endpoint_min_y(i,j) = y;
                    end
                end
            end
        end
    end
    % scale the hough matrix with values between 0 and 255  
    hough_image_out = hough_image_out.*(255/max(hough_image_out(:)));
    
    % threshold the hough 
    index = (hough_image_out >= hough_thresh);
    hough_image_out = zeros(size(hough_image_out));
    hough_image_out(index) = 1;
    [row, column] = size(hough_image_out);
    
    % display the original image for line drawing    
    imagesc(image_in);
    for i=1:row
        for j=1:column
            if hough_image_out(i,j)==1
                hold on;
                x1 = endpoint_max_x(i,j);
                x2 = endpoint_min_x(i,j);
                y1 = endpoint_max_y(i,j);
                y2 = endpoint_min_y(i,j);
                line([y1,y2], [x1,x2], 'Color', 'r');
            end
        end
    end
end