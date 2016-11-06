run('vlfeat-0.9.20/toolbox/vl_setup');

train_image_path = 'CV_Assignment3/train';
test_image_path = 'CV_Assignment3/test';
peak_thresh = 5;

% sift descriptors of training images
[features] = sift_descriptor_from_image(train_image_path, peak_thresh);
data_filepath = strcat('features_',num2str(peak_thresh),'.csv');
csvwrite(data_filepath, features);


for num_of_centers = [100, 400, 800, 1600]
    % perform kmeans
    centers = vl_kmeans(features', num_of_centers);
    centers_data_filepath = strcat('centers_',num2str(num_of_centers),'.csv');
    centers = centers';
    csvwrite(centers_data_filepath,centers);
    
    % training set of images' bag of words and labels
    [train_bag_of_word, train_scene_class] = ...
        compute_bag_of_word(train_image_path, peak_thresh, centers);
    csvwrite(strcat...
        ('train_bow_',num2str(num_of_centers),'result.csv'), train_bag_of_word);
    csvwrite(strcat...
        ('train_class_',num2str(num_of_centers),'result.csv'), train_scene_class);

    % testing set of images' bag of words and labels
    [test_bag_of_word, test_scene_class] = ...
        compute_bag_of_word(test_image_path, peak_thresh, centers);
    csvwrite(strcat...
        ('test_bow_',num2str(num_of_centers),'result.csv'), test_bag_of_word);
    csvwrite(strcat...
        ('test_class_',num2str(num_of_centers),'result.csv'), test_scene_class);
end

