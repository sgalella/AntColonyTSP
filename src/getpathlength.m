function pathLength = getpathlength(distanceMatrix, path)
%
% Function:
% - getpathlength: Calculates the total distance of a TSP tour
%
% Inputs:
% - distanceMatrix: Distance matrix (nCitiesxnCities double)
% – path: TSP tour (1xnCities double)
% 
% Outputs: 
% - pathLength: Total path distance (double)
%
% Author: sgalella
% https://github.com/sgalella

% Calculate total ant path length
pathLength = 0;
nCities = length(path);

for iCity = 1:(nCities-1)
    pathLength = pathLength + distanceMatrix(path(iCity), path(iCity+1));
end

end

