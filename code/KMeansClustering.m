function idx = KMeansClustering(X, k, visualize2D, centers)
% Run the k-means clustering algorithm.
%
% INPUTS
% X - An array of size m x n containing the points to cluster. Each row is
%     an n-dimensional point, so X(i, :) gives the coordinates of the ith
%     point.
% k - The number of clusters to compute.
% visualize2D - OPTIONAL parameter telling whether or not to visualize the
%               progress of the algorithm for 2D data. If not set then 2D
%               data will not be visualized.
% centers - OPTIONAL parameter giving initial centers for the clusters.
%           If provided, centers should be a k x n matrix where
%           centers(c, :) is the center of the cth cluster. If not provided
%           then cluster centers will be initialized by selecting random
%           rows of X. You don't need to use this parameter; it is mainly
%           here to make your code more easily testable.
%
% OUTPUTS
% idx     - The assignments of points to clusters. idx(i) = c means that the
%           point X(i, :) has been assigned to cluster c.

    if ~isa(X, 'double')
        X = double(X);
    end
    m = size(X, 1);
    n = size(X, 2);
    
    % If we are going to display the clusters graphically then create a
    % figure in which to draw the visualization.
    figHandle = [];
    if n == 2 && visualize2D
        figHandle = figure;
    end

    
    % If initial cluster centers were not provided then initialize cluster
    % centers to random rows of X. Each row of the centers variable should
    % contain the center of a cluster, so that centers(c, :) is the center
    % of the cth cluster.
    if ~exist('centers', 'var')
        centers = zeros(k, n);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        random_rows = randperm(m, k);
        centers = X(random_rows, :);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    
    % The assignments of points to clusters. If idx(i) == c then the point
    % X(i, :) belongs to the cth cluster.
    idx = zeros(m, 1);

    % The number of iterations that we have performed.
    iter = 0;
    
    % If the assignments of points to clusters have not converged after
    % performing MAX_ITER iterations then we will break and just return the
    % current cluster assignments.
    MAX_ITER = 100;
    
    while true        
        % Store old cluster assignments
        old_idx = idx;
        
        % Compute distances from each point to the centers and assign each
        % point to the closest cluster.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for sample_index = 1:m
            sample = X(sample_index, :);
            distances = zeros(k, 1);

            for t = 1:k
                center = centers(t,:);
                distances(t) = sqrt(sum((sample - center) .^ 2));
            end

            [minval, index] = min(distances);
            idx(sample_index) = index;
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Break if cluster assignments didn't change
        if idx == old_idx
            break;
        end

        % Update the cluster centers
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for t = 1:k
            sample_indexes = find(idx == t);
            num_samples = size(sample_indexes, 1);

            centers(t, :) = sum(X(sample_indexes,:)) / num_samples;
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Display the points in the 2D case.
        if n == 2 && visualize2D
            VisualizeClusters2D(X, idx, centers, figHandle);
            pause;
        end
        
        % Stop early if we have performed more than MAX_ITER iterations
        iter = iter + 1;
        if iter > MAX_ITER
            break;
        end
    end

    randi(5, 5, 5)
end
