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
% REQUIRED INPUT FILE:
% 1) BATHYMETRY FILE AS A NETCDF
import Bathymetry;
import PlotTools;
close all;
clearvars;
PlotTools.set_global_defaults();

% SAVE COLORBAR AS ITS OWN IMAGE
fig = PlotTools.create_default_figure('Figure 2 - Colorbar', [100 600 600 800]);
PlotTools.create_standalone_colorbar(Bathymetry.PLOT_CAXIS, Bathymetry.PLOT_CTICK);
PlotTools.save_image(fig, '/bathymetry/bathymetry_colorbar');

% MAKE IMAGE OF EACH BATHYMETRY
bathymetries = Bathymetry.list_all();
for plot_index = 1:1:length(bathymetries)
    bathymetry = bathymetries(plot_index);
    fig = PlotTools.create_default_figure(['Bathymetry ' bathymetry.Number ': ' bathymetry.Name]);
    plot = bathymetry.plot_self();
    PlotTools.save_image(fig, ['/bathymetry/bathymetry' bathymetry.Number]);
end
