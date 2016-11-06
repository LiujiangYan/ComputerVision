function [bag_of_word, scene_class] = compute_bag_of_word...
                                        (filepath, peak_thresh, centers)
    % cd to the training set file path
    cd(filepath);
    % get the category
    category = dir('.');

    bag_of_word = [];
    scene_class = [];
    
    for index_category=3:length(category)
        % get into the scene
        cd(category(index_category).name);
        % get the names of images
        images=dir('*.jpg');

        for index_image=1:length(images)
            index_image
            
            % get the specific image 
            try 
                image = imread(images(index_image).name);
            catch
                continue;
            end

            % check if it is RGB image, change it to gray scale image
            [~, ~, numberOfColorChannels] = size(image); 
            if numberOfColorChannels == 3
                image = rgb2gray(image);
            end

            % get the features' descriptors
            [~,feature] = vl_sift(single(image), 'PeakThresh', peak_thresh);
            
            feature = double(feature);
            % transpose so that feature has size of n by 128
            feature = feature';
            
            % if no feature is detected, skip this image
            if size(feature,1) == 0
                continue;
            end
            
            % construct the histogram for this image
            length_centers = size(centers, 1);
            hist = zeros(1, length_centers);
            for i=1:size(feature, 1)
                % get the norm of difference of this feature to centers
                diff = bsxfun(@minus, centers, feature(i,:));
                diff_norm = sum(abs(diff).^2,2).^(1/2);
                % get the minimum difference norm and related center, vote
                [~, index] = min(diff_norm);
                hist(index) = hist(index) + 1;
            end
            
            % normalize by dividing the size of features
            hist = hist./size(feature, 1);

            % add to the bag of word
            bag_of_word = [bag_of_word; hist];
            scene_class = [scene_class; index_category - 2];
        end

        % back to the training set
        cd ..
    end
    cd ../..
    
end