function [database_out, overlays_out] = p3(labels_in)
    
    overlays_out = zeros(size(labels_in));
    database_out = [];
    
    % find the num of objects in labels_in
    maxlabel = max(labels_in(:));
    labels = 1:maxlabel;
    
    % loop the labels and count the variable of each objects
    for label = 1:length(labels)
        % assign the label to the object
        database_out(label).object_label = label;
        index = (labels_in == label);
        % zeroth moment
        area = sum(index(:));
        database_out(label).area = area;
        
        % find the position of each pixel of this object
        xarray = [];
        yarray = [];
        [row, col] = size(labels_in);
        for i = 1:row
            for j = 1:col
                if labels_in(i,j) == label
                    xarray = [xarray;i];
                    yarray = [yarray;j];
                end
            end
        end
        
        % first moment
        xposition = sum(xarray)/length(xarray);
        yposition = sum(yarray)/length(xarray);
        database_out(label).x_position = xposition;
        database_out(label).y_position = yposition;
        % second moment
        xstararray = xarray - xposition;
        ystararray = yarray - yposition;
        a = sum(xstararray.*xstararray);
        b = sum(xstararray.*ystararray);
        c = sum(ystararray.*ystararray);
        theta = atan2(b,a-c)/2;
        database_out(label).orientation = theta;
        % roundness
        Emin = a*sin(theta)^2-b*sin(theta)*cos(theta)+c*cos(theta)^2;
        theta_ = theta + pi/2;
        Emax = a*sin(theta_)^2-b*sin(theta_)*cos(theta_)+c*cos(theta_)^2;
        roundness = Emin/Emax;
        database_out(label).min_moment = Emin;
        database_out(label).roundness = roundness;
        
        % plot the center and orientation of labeled zone 
        for i=-4:4
            for j=-4:4
                overlays_out(round(xposition)+i, ...
                    round(yposition)+j) = label;
            end
        end
        for i=-40:40
            overlays_out(round(xposition+i*cos(theta)), ...
                round(yposition+i*sin(theta))) = label;
        end
    end
    
end