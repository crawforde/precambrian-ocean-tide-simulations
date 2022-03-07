% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

% READS IN A BATHYMETRY FILE AND DISPLAYS A FORMATTED PLOT OF THE
% TOPOGRAPHY, WITH LANDED WHITED OUT, USING PCOLOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
import HYCOMBathymetry;
import PlotTools;
close all;
clearvars;
PlotTools.set_global_defaults(20);

% LOAD AND PLOT REAL BATHYMETRY
bathymetry = HYCOMBathymetry();
fig = PlotTools.create_default_figure(['Bathymetry ' bathymetry.Number ': ' bathymetry.Name]);
plot = bathymetry.plot_self();
cb = colorbar;
set(cb,'YTick', bathymetry.PLOT_CTICK);

% SAVE PNG FILE
PlotTools.save_image(fig, ['/bathymetry/bathymetry' bathymetry.Number]);
