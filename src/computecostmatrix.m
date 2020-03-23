function [costMatrix, distanceMatrix] = computecostmatrix(locCities)
%
% Function:
% - computeCostMatrix: Calculates the cost matrix of a group of cities
%
% Inputs:
% - locCities: Location x and y of each city (nCitiesx2 double)
% 
% Outputs: 
% – costMatrix: Cost matrix calculated as 1/distanceMatrix (nCitiesxnCities
% double)
% - distanceMatrix: Distance matrix where i, j denotes the distance
% between cities i and j (nCitiesxnCities double)
%
% Author: sgalella
% https://github.com/sgalella

% Initialize distance matrix
nCities = length(locCities);
distanceMatrix = NaN(nCities, nCities);

% Calculate distance matrix
for iCity = 1:nCities
   for jCity = 1:nCities
      if iCity == jCity
           distanceMatrix(iCity, jCity) = 0;
           continue
      end
      distanceMatrix(iCity, jCity) = pdist([locCities(iCity,:); locCities(jCity,:)]);
   end
end

costMatrix = 1./distanceMatrix;
costMatrix(isinf(costMatrix)) = NaN;

end

