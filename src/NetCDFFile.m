% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

classdef NetCDFFile < handle
    properties (Constant)
        LAT_MAX = 82
        LAT_MIN = -82
        LAT_NAME = 'LATITUDE_N'
        LAT_TICKS = [-80 -60 -40 -20 0 20 40 60 80]
        LON_MIN = 0
        LON_NAME = 'LONGITUDE_E'
        LON_TICKS = [0 60 120 180 240 300]
    end
    properties
        ParamName     % SIMPLE, SHORT PARAMETER NAME (IN FILE NAME)
        ParamNCName   % NAME OF DATA PARAMETER (AS WRITTEN IN FILE)
        FilePath      % PATH TO FILE (WITH FILE NAME)
        Lat           % STORES LATITUDE DATA
        Lon           % STORES LONGITUDE DATA
        Data          % STORES PARAMETER DATA
        RESOLUTION    % STORES GRID RESOLUTION
        LON_MAX       % STORES MAXIMUM LONGITUDE VALUE
    end
    methods
        function obj = NetCDFFile(name, ncname, file_path, resolution)
            obj.ParamName = name;
            obj.ParamNCName = ncname;
            obj.FilePath = file_path;
            obj.RESOLUTION = resolution;
            obj.LON_MAX = 360.0 - resolution;
        end
        function read(obj)
            obj.Lat = ncread(obj.FilePath, obj.LAT_NAME);
            obj.Lon = ncread(obj.FilePath, obj.LON_NAME);
            data = ncread(obj.FilePath, obj.ParamNCName);
            data = data';
            obj.Data = data;
        end
    end
    methods (Static)
        function file = read_bathymetry_file(num_str)
            import PathTools;
            file_path = PathTools.find_bathymetry_file(num_str);
            resolution = 0.125;
            if num_str == '9'
              resolution =  0.08;
            end
            temp = NetCDFFile('Bathymetry', 'TOPO', file_path, resolution);
            temp.read();
            file = temp;
        end
        function file = read_parameter_file(sim, presets)
            import PathTools;
            file_path = PathTools.find_paramter_file(sim, presets);
            resolution = 0.125;
            if sim.Number == '11'
              resolution =  0.08;
            end
            temp = NetCDFFile(presets.Name, presets.NCName, file_path, resolution);
            temp.read();
            file = temp;
        end
    end
end
