function features = ComputeFeatures(img)
% Compute a feature vector for all pixels of an image. You can use this
% function as a starting point to implement your own custom feature
% vectors.
%
% INPUT
% img - Array of image data of size h x w x 3.
%
% OUTPUT
% features - Array of computed features for all pixels of size h x w x f
%            such that features(i, j, :) is the feature vector (of
%            dimension f) for the pixel img(i, j, :).

    img = double(img);
    height = size(img, 1);
    width = size(img, 2);
    features = zeros([height, width, 1]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                         %
    %                              YOUR CODE HERE                             %
    %                                                                         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if mod(width, 2) == 0
        width_range = -width + int32(width/2.0):width - int32(width/2.0) - 1;
    else
        width_range = -width + int32(width/2.0):width - int32(width/2.0);
    end
    
    if mod(height, 2) == 0 
        height_range = -height + int32(height/2.0):height - int32(height/2.0) - 1;
    else
        height_range = -height + int32(height/2.0):height - int32(height/2.0);
    end

    [x y] = meshgrid(width_range, height_range);
    m = (x .* x) + (y .* y);
    m = -m + max(reshape(m, [], 1));
    features(:,:,1) = sqrt(double(m)) ;
end