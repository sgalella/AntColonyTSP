function transitionMatrix = computetransitionmatrix(costMatrix, pheromoneMatrix, alpha, beta)
%
% Function:
% - computetransitionmatrix: Calculates the probabilities of transition between
% different cities
%
% Inputs:
% - costMatrix: Cost matrix calculated as 1/distanceMatrix (nCitiesxnCities
% double)
% – pheromoneMatrix: Matrix containing the pheromone traces of each path
% (nCitiesxnCities double)
% – alpha: Pheromone parameter (double)
% – beta: Distance parameter (double)
% 
% Outputs: 
% - transitionMatrix: Transition matrix containing the probability of transition
% between city i and j (nCitiesxnCities double)
%
% Author: sgalella
% https://github.com/sgalella

nCities = length(costMatrix);
numerator = (costMatrix.^alpha) .* (pheromoneMatrix.^beta);
denominator = repmat(nansum((costMatrix.^alpha) .* (pheromoneMatrix.^beta), 2), 1, nCities);
transitionMatrix = numerator ./ denominator;
transitionMatrix(isnan(transitionMatrix)) = 0;

end

