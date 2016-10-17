function overlays_out = p4(labels_in, database_in)
    overlays_out = zeros(size(labels_in));
    
    % get the database of labels_in for comparing
    [database_compare, ~] = p3(labels_in);
    % record the label of compared database's fimiliar object 
    labels = [0];
    for a = database_in
        for b = database_compare
            % use roundness and area as criteria
            if abs(a.roundness-b.roundness) < 0.1 && ...
                    abs((a.area - b.area)/a.area) < 0.15
                if ~ismember(labels, b.object_label)
                    labels = [labels, b.object_label];
                    % draw the position and orientation
                    for i=-4:4
                        for j=-4:4
                            overlays_out(round(b.x_position)+i, ...
                                round(b.y_position)+j) = b.object_label;
                        end
                    end
                    for i=-40:40
                        overlays_out(round(b.x_position+i*cos(b.orientation)),...
                            round(b.y_position+i*sin(b.orientation))) = b.object_label;
                    end
                end
            end
        end
    end
    
end