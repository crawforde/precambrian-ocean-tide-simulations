% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

import iosr.statistics.*;
import NetCDFFile;
import ParameterPresets;
import PlotTools;
import Simulation;

clearvars;
close all;

% FIGURE SETTINGS
PlotTools.set_global_defaults(20);
main_label_font_size = 32;

% READ IN CONFIGURATION FOR ALL THE SIMULATIONS THAT WE WANT TO ADD TO OUR PLOT.
simulations = Simulation.list_primary();
% A PRESETS
presets = ParameterPresets.by_name('A');
% FOR CONVERTING A VALUES FROM m/s TO cm/s
scale_factor = 100;

% DIMENSIONS OF m x n MATRICES THAT WE WILL USE TO STORE SIMULATION DATA AND
% CORRESPONDING CELL ARES (WEIGHTS). n IS THE NUMBER OF SIMULATIONS AND m IS
% EQUAL TO THE NUMBER OF DATA POINTS IN THE SIMULATION WITH THE MAXIMUM NUMBER
% OF SHELF CELLS (NOTE: WE DON'T YET KNOW THE FINAL VALUE OF m AND WILL UPDATE
% IT DYNAMICALLY). EACH MATRIX COLUMN WILL CONTAINS DATA FROM ONE SIMULTAION.
% IN ORDER FOR COLUMN VECTORS TO HAVE THE SAME DIMENSIONS, THOSE WITH FEWER DATA
% POINTS, (I.E. LENGTH l < n) WILL HAVE ZEROS FOR INDICES l+1 to n.
m = 0;
n = length(simulations);
% x IS ESSENTIALLY JUST A SIMULATION COUNT. ONE BOXPLOT WILL BE SHOWN ON THE
% GRAPH AT EACH x TICK.
x = (1:1:n);
x_tick_labels = {};
% MATRIX y STORES VALUES OF a, AND weights STORES CORRESPONDING SHELF AREAS.
y = [];
weights = [];

% LOOP THROUGH SIMULATIONS. FOR EACH SIMULATION, ADD A COLUMN VECTOR TO EACH
% MATRIX.
for j = 1:1:n
  sim = simulations(j);
  x_tick_labels{j} = sim.Number;
  % READ DATA FROM NETCDF FILES.
  parameter_file = NetCDFFile.read_parameter_file(sim, presets);
  a_values = parameter_file.Data;
  bathymetry_file = NetCDFFile.read_bathymetry_file(sim.Bathymetry.Number);
  depth = bathymetry_file.Data;
  % GET MATRIX OF CORRESPONDING CELL AREAS THAT WILL BE USED AS WEIGHTS.
  cell_areas = getCellAreas( ...
    parameter_file.LAT_MAX,  ...
    parameter_file.LAT_MIN,  ...
    parameter_file.RESOLUTION)*100000;
  % PICK OUT NON-NAN PARAMETER DATA CORRESPONDIG TO SHELF POINTS. APPLY SAME
  % FILTER TO WEIGHTS MATRIX. FLATTEN MATRICES TO COLUMN VECTORS.
  shelf_a_values = a_values(depth<=135 & depth > 0 & ~isnan(a_values));
  shelf_cell_areas = cell_areas(depth<=135 & depth > 0 & ~isnan(a_values));

  % CHECK IF WE NEED TO INCREASE DIMENSIONS OF MATRICES OR VECTORS.
  l = length(shelf_a_values);
  if l > m
    % CASE 1: NEED TO INCREASE DIMENSION m OF MATRICES
    y((m+1):l, 1:(j - 1)) = zeros(l-m, j - 1);
    weights((m+1):l, 1:(j - 1)) = zeros(l-m, j - 1);
    m = l;
  elseif l < m
    % CASE 2: NEED TO INCREASE LENGTH OF VECTORS TO m
    shelf_a_values(l+1:m, 1) = zeros(m - l, 1);
    shelf_cell_areas(l+1:m, 1) = zeros(m - l, 1);
  end

  % ADD COLUMN VECTORS TO MATRICES.
  y(:, j) = (shelf_a_values) .* scale_factor;
  weights(:, j) = shelf_cell_areas;
end

% CREATE AND FORMAT PLOT.
fig = PlotTools.create_default_figure('Box Plots of A in Continental Shelves for Primary Simulations');
bp = boxPlot(x, y, 'weights', weights, 'showMean', true, 'outlierSize', 16, 'showOutliers', true);
set(gca, 'XTickLabel', x_tick_labels);
grid on;
set(gca, 'XGrid', 'off', 'GridAlpha', 0.3, 'MinorGridAlpha', 0.4);
grid minor;
pause(3);
PlotTools.save_image(fig, '/shelf_a/shelf_a_box_and_whisker_primary_sims_linear');
grid minor;
set(gca, 'Yscale', 'log', 'YLim', [0.1 1000], 'YTick', [0.1 1 10 100 1000], 'YTickLabel', {'0.1', '1', '10', '100', '1000'});
pause(3);
PlotTools.save_image(fig, '/shelf_a/shelf_a_box_and_whisker_primary_sims_log');
