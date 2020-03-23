function path = generatepath(transitionMatrix)
%
% Function:
% - generatePath: Generates a valid TSP tour
%
% Inputs:
% - transitionMatrix: Transition matrix containing the probability of transition
% between city i and j (nCitiesxnCities double)
% 
% Outputs: 
% - path: TSP tour (1xnCities double)
%
% Author: sgalella
% https://github.com/sgalella

% Select random initial city
nCities = length(transitionMatrix);
path = NaN(1, nCities+1);
randCity = randsample(nCities, 1);
path(1) = randCity;
transitionMatrix(:, path(1)) = 0;

for iCities = 2:nCities
   randCity = randsample(nCities, 1, true, transitionMatrix(path(iCities-1), :));
%    while any(ismember(path, randCity))
%        randCity = randsample(nCities, 1, true, transitionMatrix(path(iCities-1), :));
%    end
   path(iCities) = randCity;
   transitionMatrix(:, path(iCities)) = 0;
end

path(nCities+1) = path(1);

end

