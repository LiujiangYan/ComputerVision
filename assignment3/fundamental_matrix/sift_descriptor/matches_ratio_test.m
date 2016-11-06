function matches = matches_ratio_test(descriptors1, descriptors2)
    % the threshold
    threshold = 0.6;
    matches = [];
    
    % get the ssd between each possible pair of matching
    ssd = zeros(length(descriptors1(:,1)), length(descriptors2(:,1))); 
    for i=1:length(descriptors1(:,1))
        for j=1:length(descriptors2(:,1))
            ssd(i,j) =  norm(descriptors1(i,:)-descriptors2(j,:));
        end
    end
    
    % loop each row, getting the first and second ssd
    % if the difference satisfied the threshold then match
    for i=1:length(descriptors1(:,1))
        [first_shortest_distance, first] = min(ssd(i,:));
        ssd(i,first) = inf;
        [second_shortest_distance, second] = min(ssd(i,:));
        if first_shortest_distance < threshold*second_shortest_distance
            matches = [matches; i, first];
        end
    end
end
