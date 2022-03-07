% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

classdef Bathymetry
    properties (Constant)
        GRID_DEPTH_UNITS = 'm'
        GRID_MAX_LAT = 82
        GRID_MIN_LAT = -82
        GRID_MAX_LON = 359.875
        GRID_MIN_LON = 0
        GRID_RESOLUTION = 0.125
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
        Subfolder     % SUBFOLDER WHERE BATHYMETRY FILE IS STORED (STRING)

    end
    methods
        function obj = Bathymetry(num_str, name, subfolder)
            import PathTools;
            obj.Number = num_str;
            obj.Name = name;
            obj.Subfolder = subfolder;
            obj.FilePath = PathTools.find_bathymetry_file(num_str);
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
            data_formatted(data_formatted==0) = nan;
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
            caxis(Bathymetry.PLOT_CAXIS);
            plot = plot1;
        end
    end
    methods (Static)
        function obj = by_number(number)
            switch number
                case 0
                    obj = Bathymetry('0', 'real', 'real');
                case 1
                    obj = Bathymetry('1', 'default', 'default');
                case 2
                    obj = Bathymetry('2', 'half_area_deep', 'half_area_deep');
                case 3
                    obj = Bathymetry('3', 'half_area', 'half_area');
                case 4
                    obj = Bathymetry('4', 'twice_shelf', 'twice_shelf');
                case 5
                    obj = Bathymetry('5', 'translated_lon', 'translated_lon');
                case 6
                    obj = Bathymetry('6', 'translated_lat', 'translated_lat');
                case 7
                    obj = Bathymetry('7', 'broken', 'broken');
                case 8
                    obj = Bathymetry('8', 'supercontinent', 'supercontinent');
            end
        end
        function arr = list_all()
            b0 = Bathymetry.by_number(0);
            b1 = Bathymetry.by_number(1);
            b2 = Bathymetry.by_number(2);
            b3 = Bathymetry.by_number(3);
            b4 = Bathymetry.by_number(4);
            b5 = Bathymetry.by_number(5);
            b6 = Bathymetry.by_number(6);
            b7 = Bathymetry.by_number(7);
            b8 = Bathymetry.by_number(8);
            arr = [b0 b1 b2 b3 b4 b5 b6 b7 b8];
        end
    end
end
