function error = verify_F(left_features, right_features, matches, F)
    error = 0;
    for i=1:size(matches,1)
        ul = left_features(matches(i,1),1);
        vl = left_features(matches(i,1),2);
        ur = right_features(matches(i,2),1);
        vr = right_features(matches(i,2),2);
        error = error + [ul vl 1]*F*[ur; vr; 1];
    end
end