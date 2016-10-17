function line_image_out = p7(image_in, hough_image_in, hough_thresh)
    line_image_out = image_in;
    
    % threshold the hough matrix by the hough threshhold input
    index = (hough_image_in >= hough_thresh);
    hough_image_in = zeros(size(hough_image_in));
    hough_image_in(index) = 1;
    [row, column] = size(hough_image_in);
    
    % define the rho max as the length of diagonal
    % define the line length for drawing
    rho_max = sqrt(length(image_in(1,:))^2 + length(image_in(:,1))^2);
    linelength = 10000;
    % display the image for line drawing
    imagesc(line_image_out);
    % loop the hough matrix 
    for i=1:row
        for j=1:column
            % get the parameters with votes over threshold
            if hough_image_in(i,j)==1
                % compute the corresponding parameters
                theta = pi*i/row-pi/2;
                rho = 2*rho_max*j/column - rho_max;
                % draw the liens
                x0 = -rho/sin(theta);
                x1 = x0 + linelength*cos(theta);
                y1 = linelength*sin(theta);
                x2 = x0 - linelength*cos(theta);
                y2 = -linelength*sin(theta);
                hold on;
                line([y1,y2], [x1,x2], 'Color', 'r');
            end
        end
    end
end