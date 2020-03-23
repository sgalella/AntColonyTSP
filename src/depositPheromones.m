function [pheromoneMatrix, pathLength] = depositPheromones(path, costMatrix, pheromoneMatrix)
%
% Function:
% - depositPheromones: Updates pheromone matrix with ant path
%
% Inputs:
% - path: TSP tour (1xnCities double)
% – costMatrix: Cost matrix calculated as 1/distanceMatrix (nCitiesxnCities
% double)
% – pheromoneMatrix: Matrix containing the pheromone traces of each path
% (nCitiesxnCities double)
% 
% Outputs: 
% – pheromoneMatrix: Updated matrix containing the pheromone traces of each path
% (nCitiesxnCities double)
% - pathLength: Total path distance (double)
%
% Author: sgalella
% https://github.com/sgalella

% Calculate total ant path length
pathLength = 0;
nCities = length(costMatrix);

for iCity = 1:(nCities-1)
    pathLength = pathLength + costMatrix(path(iCity), path(iCity+1));
end

for iCity = 1:(nCities-1)
    pheromoneMatrix(path(iCity), path(iCity+1)) = pheromoneMatrix(path(iCity), path(iCity+1)) + pathLength;
end

  
end

