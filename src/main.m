%%%%% Main %%%%%
%
% Plots and run the ant system algorithm for solving the TSP
%
% Author: sgalella
% https://github.com/sgalella

% Clear command window
clear; clc;

% Random seed
seed = 1234;
rng(seed);

% Create random city map
nCities = 10;
mapSize = 100;
locCities = NaN(nCities, 2);

iCities = 1;
while iCities <= nCities
   newCity = randsample(mapSize, 2, true)'; 
   if ~ismember(newCity, locCities, 'rows')
      locCities(iCities, :) = newCity;
      iCities = iCities + 1;
   end
end

% Plot cities location
set(0,'defaultTextInterpreter','latex')
fig1 = figure(1);
hold on;
for iCities = 1:nCities
    plot(locCities(iCities,1), locCities(iCities,2), 'r.', 'MarkerSize', 20)
    text(locCities(iCities,1)+2*mapSize/100, locCities(iCities,2)+2*mapSize/100, num2str(iCities), 'FontSize', 15);
end
hold off;
xlim([0 mapSize])
ylim([0 mapSize])
xlabel('x', 'FontSize', 15)
ylabel('y', 'FontSize', 15)
title('Cities Location', 'FontSize', 20)
grid on;
ax = gca;
ax.GridAlpha = 0.3;
saveas(fig1, '../images/cities_location.jpg');

% Create distance matrix
[costMatrix, distanceMatrix] = computecostmatrix(locCities);

% Initialize pheromone matrix
pheromoneMatrix = ones(size(costMatrix));
pheromoneMatrix = pheromoneMatrix - diag(diag(pheromoneMatrix));


% Define transition matrix
alpha = 1;
beta = 1;
transitionMatrix = computetransitionmatrix(costMatrix, pheromoneMatrix, alpha, beta);

% Run the algorithm
nAnts = 100;
ro = 0.3;
nIterations = 100;
nPrintInfo = 10;

fig2 = figure(2);
bestPathAll = [];
bestLengthAll = Inf;
optimalPathIterations = NaN(1, nIterations);

for iIteration = 1:nIterations
    for iAnt = 1:nAnts
        path = generatepath(transitionMatrix);
        pheromoneMatrix = depositPheromones(path, costMatrix, pheromoneMatrix);
        transitionMatrix = computetransitionmatrix(costMatrix, pheromoneMatrix, alpha, beta);
    end
    pheromoneMatrix = evaporatepheromonematrix(pheromoneMatrix, ro);
    bestPathIteration = generatepath(transitionMatrix);
    bestLengthIteration = getpathlength(distanceMatrix, bestPathIteration);
    optimalPathIterations(iIteration) = bestLengthIteration;
    if bestLengthIteration < bestLengthAll
       bestPathAll = bestPathIteration;
       bestLengthAll = bestLengthIteration;
    end
    
    % Plot path length
    fig2 = figure(2);
    plot(1:iIteration, optimalPathIterations(1:iIteration),'b','LineWidth', 2);
    xlabel('iterations', 'FontSize', 15)
    ylabel('path length', 'FontSize', 15)
    title('Path Convergence', 'FontSize', 20)
    grid on;
    ax = gca;
    ax.GridAlpha = 0.3;
    pause(0.05);
    drawnow;
    
    if mod(iIteration, nPrintInfo) == 0
        fprintf("Iteration %d: Path length: %f\n", iIteration, bestLengthIteration);
    end
end
fprintf("Final Iteration: Best length: %f\n", bestLengthAll);
saveas(fig2, '../images/path_convergence.jpg');

% Plot final network
fig3 = figure(3);
hold on;
for iCities = 1:nCities
    for jCities = 1:nCities
        p = round(transitionMatrix(iCities, jCities), 3);
        if p ~= 0
            plot([locCities(iCities, 1) locCities(jCities, 1)], [locCities(iCities, 2) locCities(jCities, 2)], 'r', 'LineWidth', 1+2*p)
        end
    end
end

for iCities = 1:nCities
    plot(locCities(iCities,1), locCities(iCities,2), 'r.', 'MarkerSize', 20)
    text(locCities(iCities,1)+2*mapSize/100, locCities(iCities,2)+2*mapSize/100, num2str(iCities), 'FontSize', 15);
end
hold off;
xlim([0 mapSize])
ylim([0 mapSize])
xlabel('x', 'FontSize', 15)
ylabel('y', 'FontSize', 15)
title('Final Network', 'FontSize', 20)
grid on;
ax = gca;
ax.GridAlpha = 0.3;
saveas(fig3, '../images/final_network.jpg');

% Plot the best path
fig4 = figure(4);
hold on;

for iCities = 1:length(bestPathAll)-1
    plot([locCities(bestPathAll(iCities),1) locCities(bestPathAll(iCities+1),1)], [locCities(bestPathAll(iCities),2) locCities(bestPathAll(iCities+1),2)], 'r', 'LineWidth', 3)
end

for iCities = 1:nCities
    plot(locCities(bestPathAll(iCities),1), locCities(bestPathAll(iCities),2), 'r.', 'MarkerSize', 20)
    text(locCities(bestPathAll(iCities),1)+2*mapSize/100, locCities(bestPathAll(iCities),2)+2*mapSize/100, num2str(bestPathAll(iCities)), 'FontSize', 15);
end

hold off;
xlim([0 mapSize])
ylim([0 mapSize])
xlabel('x', 'FontSize', 15)
ylabel('y', 'FontSize', 15)
title('Best Path', 'FontSize', 20)
grid on;
ax = gca;
ax.GridAlpha = 0.3;
saveas(fig4, '../images/best_path.jpg');
