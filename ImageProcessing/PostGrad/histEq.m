function eqIm = histEq(image)
    [row,col] = size(image);
    % Construct the cumulative histogram
    for i=1:255
        cumHist(i) = sum(sum(image <= i))/(row*col);
    end
    % Use it to transform the grey level in each pixel.
    eqIm = fix(255*cumHist(image));
end