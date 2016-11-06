function m_classfied = classify(m)
    [row, column] = size(m);
    m_classfied = zeros(size(m));
    for r=1:row
        for c=1:column
            if m(r,c) > 157.5 || m(r,c) <= -157.5
                m_classfied(r,c) = 1;
            elseif m(r,c) > -157.5 && m(r,c) <= -112.5
                m_classfied(r,c) = 2;
            elseif m(r,c) > -112.5 && m(r,c) <= -67.5
                m_classfied(r,c) = 3;
            elseif m(r,c) > -67.5 && m(r,c) <= -22.5
                m_classfied(r,c) = 4;
            elseif m(r,c) > -22.5 && m(r,c) <= 22.5
                m_classfied(r,c) = 5;
            elseif m(r,c) > 22.5 && m(r,c) <= 67.5
                m_classfied(r,c) = 6;
            elseif m(r,c) > 67.5 && m(r,c) <= 122.5
                m_classfied(r,c) = 7;
            elseif m(r,c) > 122.5 && m(r,c) <= 157.5
                m_classfied(r,c) = 8;
            end
        end
    end
end
