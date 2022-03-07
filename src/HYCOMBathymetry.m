% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

classdef HYCOMBathymetry
    properties (Constant)
        GRID_DEPTH_UNITS = 'm'
        GRID_MAX_LAT = 82
        GRID_MIN_LAT = -82
        GRID_MAX_LON = 359.92
        GRID_MIN_LON = 0
        GRID_RESOLUTION = 0.08
        NC_VAR_NAME_LON = 'LONGITUDE_E'
        NC_VAR_NAME_LAT = 'LATITUDE_N'
        NC_VAR_NAME_DEPTH = 'TOPO'
        PLOT_CAXIS = [0 5000]
        PLOT_CTICK = (0:1000:5000)
        PLOT_XTICK = [0 60 120 180 240 300]
        PLOT_YTICK = [-80 -60 -40 -20 0 20 40 60 80]
    end
    properties
        FilePath      % PATH TO ASSOCIATED BATHYMETRY FILES
        Number        % BATHYMETRY NUMBER # (STRING)
        Name          % BATHYMETRY NAME (STRING)

    end
    methods
        function obj = HYCOMBathymetry()
            import PathTools;
            obj.Number = '9';
            obj.Name = 'HYCOM';
            obj.FilePath = PathTools.find_bathymetry_file(obj.Number);
        end
        function data = read_lon(obj)
            data = ncread(obj.FilePath, Bathymetry.NC_VAR_NAME_LON);
        end
        function data = read_lat(obj)
            data = ncread(obj.FilePath, Bathymetry.NC_VAR_NAME_LAT);
        end
        function data = read_depth(obj)
            data = ncread(obj.FilePath, Bathymetry.NC_VAR_NAME_DEPTH);
        end
        function output_data = read_depth_formatted(obj)
            data_raw = obj.read_depth();
            data_formatted = data_raw';
            fill_value = max(data_formatted(:));
            data_formatted(data_formatted==fill_value) = nan;
            output_data = data_formatted;
        end
        function plot = plot_self(obj)
            lon = obj.read_lon();
            lat = obj.read_lat();
            depth = obj.read_depth_formatted();
            plot1 = pcolor(lon, lat, depth);
            set(plot1, 'EdgeColor', 'none');
            xmin = Bathymetry.GRID_MIN_LON;
            xmax = Bathymetry.GRID_MAX_LON;
            ymin = Bathymetry.GRID_MIN_LAT;
            ymax = Bathymetry.GRID_MAX_LAT;
            set(gca, 'YDir', 'normal');
            set(gca, 'XTick', Bathymetry.PLOT_XTICK);
            set(gca, 'YTick', Bathymetry.PLOT_YTICK);
            set(gca, 'layer', 'top')
            axis([xmin xmax ymin ymax]);
            caxis(obj.PLOT_CAXIS);
            plot = plot1;
        end
    end
end
