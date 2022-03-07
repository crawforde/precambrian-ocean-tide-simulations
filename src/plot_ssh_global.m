% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

import NetCDFFile;
import ParameterPresets;
import PlotTools;
import Simulation;
close all;
clearvars;
PlotTools.set_global_defaults();

presets = ParameterPresets.by_name('SSH_Amp');

% MAKE COLORBAR IN ITS OWN FIGURE
fig = PlotTools.create_default_figure('Figure 3 - Colorbar', [100 600 600 800]);
PlotTools.create_standalone_colorbar(presets.CRange, presets.CTicks);
PlotTools.save_image(fig, '/global_ssh_amp/global_ssh_amp_colorbar');

simulations = Simulation.list_all();
for plot_index = 1:1:length(simulations)
  sim = simulations(plot_index);
  fig = PlotTools.create_default_figure(['Global SSH Amplitudes - simulation #' sim.Number]);
  file = NetCDFFile.read_parameter_file(sim, presets);
  PlotTools.plot_parameter(presets, file);
  PlotTools.save_image(fig, ['/global_ssh_amp/global_ssh_amp_' sim.Number]);
end
