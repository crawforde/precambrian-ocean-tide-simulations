% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

import ParameterPresets;
import PlotTools;
import Simulation;
% Clear environment and set plotting defaults
close all;
clearvars;
PlotTools.set_global_defaults(20);
% Get parameter settings and simulation list
presets = ParameterPresets.by_name('S');
simulations = Simulation.list_all();
% Generate a plot for each simulation
for plot_index = 1:1:length(simulations)
    % Perform histogram/stats calculations
    sim = simulations(plot_index);
    [x, y, weighted_mean, percent_geq_critical] = get_shelf_histogram(sim, presets);
    percent_less_than_critical = 100 - percent_geq_critical;
    % Plot data
    fig = PlotTools.create_default_figure(['Figure 6 - simulation #' sim.Number]);
    PlotTools.plot_log_histogram(x, y, presets, weighted_mean);
    PlotTools.add_plot_text(0.52, 0.95, ['Weighted Mean: ', num2str(weighted_mean, '%.4f')]);
    PlotTools.add_plot_text(0.52, 0.89, ['Critical: ', num2str(presets.HXCritical)]);
    PlotTools.add_plot_text(0.52, 0.83, ['Percent < Critical: ', num2str(percent_less_than_critical, '%.3f')]);
    PlotTools.add_plot_text(0.52, 0.77, ['Bin Size: ', num2str(presets.HBin)]);
    % Save image
    PlotTools.save_image(fig, ['/shelf_s/shelf_s_hist_' sim.Number]);
end
