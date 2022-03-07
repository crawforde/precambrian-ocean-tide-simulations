% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

classdef PathTools
    methods (Static)
        function root_path = get_root()
            root_path = getenv('PROJECT_ROOT_PATH');
        end
        function new_path = gen_path(relative_path)
            new_path = [PathTools.get_root() relative_path];
        end
        function file_path = find_bathymetry_file(num_str)
            file_path = PathTools.gen_path(['bathymetries/' num_str '/bathymetry.nc']);
        end
        function file_path = find_paramter_file(sim, presets)
            filename = [presets.Name '_Sim' sim.Number '.nc'];
            file_path = PathTools.gen_path(['data/' sim.Number '/' filename]);
        end
    end
end
