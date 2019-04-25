% Simple script to run ComputeSegmentation.

% Read the input image.
img = imread('../imgs/grey-american-shorthair.jpg');

% Choose the number of clusters and the clustering method.
k = 2;
clusteringMethod = 'kmeans';

% Choose the feature function that will be used. The @ syntax creates a
% function handle; this allows us to pass a function as an argument to
% another function.
featureFn = @ComputeColorCentralityFeatures;

% Whether or not to normalize features before clustering.
normalizeFeatures = false;

% Whether or not to resize the image before clustering. If this script
% runs too slowly then you should set resize to a value less than 1.
resize = 1.0;

% Use all of the above parameters to actually compute a segmentation.
segments = ComputeSegmentation(img, k, clusteringMethod, featureFn, ...
                               normalizeFeatures, resize);
                           
% Show the computed segments in two different ways.
ShowSegments(img, segments);
ShowMeanColorImage(img, segments);