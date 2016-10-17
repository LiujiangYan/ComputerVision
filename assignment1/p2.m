function labels_out = p2(binary_in)
    
    [row, column] = size(binary_in);
    
    newlabel = 1;
    % labelarray for tracking the equivalence
    % use vector for rooted tree
    labelarray = zeros(1,1000);
    
    % the first pixel
    if binary_in(1,1) == 1
        labels_out(1,1) = newlabel;
        newlabel = newlabel + 1;
    end
    
    % the first column of image
    for j = 2:column
        if binary_in(1,j) == 0
            labels_out(1,j) = 0;
        else
            if labels_out(1,j-1) ~= 0
                labels_out(1,j) = labels_out(1,j-1);
            else
                labels_out(1,j) = newlabel;
                newlabel = newlabel + 1;
            end
        end
    end
    
    % the first row of image
    for i = 2:row
        if binary_in(i,1) == 0
            labels_out(i,1) = 0;
        else
            if labels_out(i-1,1) ~= 0
                labels_out(i,1) = labels_out(i-1,1);
            else
                labels_out(i,1) = newlabel;
                newlabel = newlabel + 1;
            end
        end
    end
    
    % assign the labels to other pixels 
    for i = 2:row
        for j = 2:column
            % if the value of pixel is 0, then not labeled
            if binary_in(i,j) == 0
                labels_out(i,j) = 0;
            else
                % A B
                % C D
                % A labeled; then label D = label A;
                if labels_out(i-1,j-1) ~= 0
                    labels_out(i,j) = labels_out(i-1,j-1);
                % A not labeled; B labeled and C not labeled; 
                % then label D = label B;
                elseif labels_out(i-1,j) ~= 0 && labels_out(i,j-1) == 0
                    labels_out(i,j) = labels_out(i-1,j);
                % A not labeled; C labeled and B not labeled; 
                % then label D = label C;
                elseif labels_out(i-1,j) == 0 && labels_out(i,j-1) ~= 0
                    labels_out(i,j) = labels_out(i,j-1);
                % A not labeled; B and C labeled equally; 
                % then label D = label B = label C;
                elseif labels_out(i-1,j) == labels_out(i,j-1) ...
                        && labels_out(i-1,j) ~= 0 && labels_out(i,j-1) ~= 0
                    labels_out(i,j) = labels_out(i-1,j);
                % A not labeled; B and C labeled inequally; 
                % then label D = label B, notes that label B = label C;
                elseif labels_out(i-1,j) ~= labels_out(i,j-1) ...
                        && labels_out(i-1,j) ~= 0 && labels_out(i,j-1) ~= 0
                    labels_out(i,j) = labels_out(i-1,j);
                    
                    % find the root of tree which B belongs to
                    root_right = labels_out(i-1,j);
                    while labelarray(root_right) ~= 0
                        root_right = labelarray(root_right);
                    end
                    % find the root of tree which C belongs to
                    root_left = labels_out(i,j-1);
                    while labelarray(root_left) ~= 0
                        root_left = labelarray(root_left);
                    end
                    % if they are the same, do nothing; 
                    % otherwise, assign the C tree root to the B tree root
                    if root_right ~= root_left
                        labelarray(root_right) = root_left;
                    end

                % A B C not labeled, assign a new label to D;
                else
                    labels_out(i,j) = newlabel;
                    newlabel = newlabel + 1;
                end
            end
        end
    end    
    
    % deal with the equivalence tree
    labels = [];
    for i = 1:length(labelarray)
        j = i;
        while labelarray(j) ~= 0
            j = labelarray(j);
        end
        index = (labels_out==i);
        labels_out(index) = j;
        if ~ismember(j, labels)
            labels = [labels, j];
        end
    end
    
    % reassign the labels to the image
    reassign = 1;
    for i = 1:length(labels)
        index = (labels_out==labels(i));
        labels_out(index) = reassign;
        reassign = reassign + 1;
    end
    
end