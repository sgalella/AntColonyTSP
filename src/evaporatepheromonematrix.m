function pheromoneMatrixEvaporated = evaporatepheromonematrix(pheromoneMatrix, ro)
%
% Function:
% - evaporatePheromoneMatrix: Removes pheromones from paths
%
% Inputs:
% - pheromoneMatrix: Matrix containing the pheromone traces of each path
% (nCitiesxnCities double)
% – ro: Proportion of pheromone elimnated (double)
% 
% Outputs: 
% - pheromoneMatrixEvaporated: Updated pheromoneMatrix with pheromones removed 
% (nCitiesxnCities double)
%
% Author: sgalella
% https://github.com/sgalella

assert(0 <= ro && ro <= 1, 'Evaporation parameter (ro) has to be in the range [0, 1]')
pheromoneMatrixEvaporated = (1-ro)*pheromoneMatrix;

end

