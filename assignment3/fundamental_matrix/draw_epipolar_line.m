function result = draw_epipolar_line(image_left, image_right, ...
    feature_coordinate_left, feature_coordinate_right, matches, F)
    
    % randomly get eight feature points
    random_vector = randi([1 length(matches)], 1, 8);
    for i=1:length(random_vector)
        random_matches(i,:) = matches(random_vector(i), :);
    end
    
    % get the offset 
    [~,offset,~] = size(image_left);
    
    % display the side by side image
    SbS = [image_left, image_right];
    imshow(SbS);
    
    % the radius of the mark of the feature
    r=3;
    for i=1:size(random_matches,1)
        % draw the mark of every feature in circluar shape
        rectangle('Position',...
            [feature_coordinate_left(random_matches(i,1),2)-r, ...
             feature_coordinate_left(random_matches(i,1),1)-r, 2*r, 2*r],...
            'Curvature',[1 1],'edgecolor','r');
        rectangle('Position',...
            [feature_coordinate_right(random_matches(i,2),2)-r+offset, ...
             feature_coordinate_right(random_matches(i,2),1)-r, 2*r, 2*r],...
            'Curvature',[1 1],'edgecolor','r');
    end
    
    % draw the epipolar lines in right image
    for i=1:size(random_matches,1)
        % get ul and vl
        u_l = feature_coordinate_left(random_matches(i,1),1);
        v_l = feature_coordinate_left(random_matches(i,1),2);
        u = [u_l, v_l, 1];
        % compute the coeffients for line equation
        coef = u*F;
        
        % set the startpoint and endpoint's coordinates
        startpoint_y = - coef(3)/coef(1);
        startpoint_x = offset;
        
        endpoint_y = -(coef(2)*offset + coef(3))/coef(1);
        endpoint_x = 2*offset;

        % draw the line
        line([startpoint_x endpoint_x],[startpoint_y endpoint_y],...
            'LineWidth',0.3,'Color','g');
    end
end