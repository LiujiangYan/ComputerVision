function res = display_matched(image1, image2, ...
                                features1, features2, matches_mark)
    
    % get the offset 
    [~,offset,~] = size(image1);
    
    [h1, w1] = size(image1);
    [h2, w2] = size(image2);
    % check if the size of images are consistent
    if h1 < h2
        image1(h1+1:h2,:)=0;
    elseif h1 > h2
        image2(h2+1:h1,:)=0;
    end
    
    % display the side-by-side image
    SbS = [image1 image2];
    imshow(SbS);
    
    % the radius of the mark of the feature
    r=3;
    for i=1:length(matches_mark)
        % draw the mark of every feature in circluar shape
        rectangle('Position',[features1(matches_mark(i,1),2)-r, ...
            features1(matches_mark(i,1),1)-r, 2*r, 2*r],...
            'Curvature',[1 1],'edgecolor','b');
        rectangle('Position',[features2(matches_mark(i,2),2)-r+offset, ...
            features2(matches_mark(i,2),1)-r, 2*r, 2*r],...
            'Curvature',[1 1],'edgecolor','b');
    end
    
    % deal with the non-marked matches (non-formed case)
    [~,width] = size(matches_mark);
    if width == 2
        matches_mark(:,3) = 0;
    end

    for i=1:length(matches_mark)
        % get the endpoints of the line connecting two matched features
        startpoint = [features1(matches_mark(i,1),1), ...
                        features2(matches_mark(i,2),1)];
        endpoint = [features1(matches_mark(i,1),2), ...
                        features2(matches_mark(i,2),2)+offset];
        % if agree with the transformation, green
        % if not, red
        if matches_mark(i,3) == 1
            line(endpoint,startpoint,'LineWidth',0.3,'Color','g');
        else
            line(endpoint,startpoint,'LineWidth',0.3,'Color','r');
        end
    end
end