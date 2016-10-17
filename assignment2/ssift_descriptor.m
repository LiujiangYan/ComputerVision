function [ descriptors ] = ssift_descriptor(feature_coords,image)
	%%%
	% Computer Vision 600.461/661 Assignment 2
	% Args:
	%	feature_coords: list of (row,col) tuple feature coordinates from image
	%	image: The input image to compute ssift descriptors on. Note: this is NOT the image name or image path.
	% Returns:
	%	descriptors: n-by-128 ssift descriptors. The first row corresponds
	%	to the ssift descriptor of the first feature (index=1) in
	%	feature_coords
	%%%
    
    image = rgb2gray(image);
    descriptors = zeros(length(feature_coords),128);
    
    % Robert
    robert_x = [0 1; -1 0];
    robert_y = [1 0; 0 -1];
    
    % calculate the derivative of both directions
    Ix = filter2(robert_x, double(image));
    Iy = filter2(robert_y, double(image));
    % the magnitude of each pixel
    Im = sqrt(Ix.^2+Iy.^2);
    
    % calculate each pixel's orientation and throw it to exact bin
    gradient = zeros(size(Im));
    for i=1:length(Ix(:,1))
        for j=1:length(Ix(1,:))
            gradient(i,j)=atan2(Ix(i,j),Iy(i,j))/pi*180;
        end
    end
    gradient_classified = classify(gradient);
    
    % loop each feature
    for n=1:length(feature_coords)
        xc = feature_coords(n,1);
        yc = feature_coords(n,2);
        
        % ignore boundary
        if xc > 20 && xc < length(image(:,1))-20 ...
            && yc > 20 && yc < length(image(1,:))-20
            
            % count is the label of the 4*4 patch
            count = 0;
            for i = [-2,-1,0,1]
                for j = [-2,-1,0,1]
                    if i<0
                        x = (xc+i*10):(xc+i*10+9);
                    else
                        x = (xc+i*10+1):(xc+i*10+10);
                    end
                    if j<0
                        y = (yc+j*10):(yc+j*10+9);
                    else
                        y = (yc+j*10+1):(yc+j*10+10);
                    end
                    
                    % get the sub matrix
                    % sum the magnitude of each bin to construct the vector
                    % there are 16 this kind of vector (4*4 submatrix)
                    submatrix = gradient_classified(x, y);
                    subsum = Im(x,y);
                    for bin=0:7
                        index = (submatrix==(bin+1));
 
                        sumofbin = subsum(index);
                        sumofbinS = sum(sumofbin(:));
                        
                        descriptors(n, 8*count+bin+1) = sumofbinS;
                    end
                    count = count + 1;
                    
                end
            end    
        end
    end
    
    % normalize
    for i=1:length(descriptors(:,1))     
        % normalize
        descriptors(i,:) = descriptors(i,:)/norm(descriptors(i,:));
        for j=1:128
            % threshold to 0.2 as maximum
            if descriptors(i,j)>0.2
                descriptors(i,j) = 0.2;
            end
        end
        % normalize again
        descriptors(i,:) = descriptors(i,:)/norm(descriptors(i,:));
    end
    
end