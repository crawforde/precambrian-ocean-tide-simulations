% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

function [x, y, weighted_mean, percent_geq_critical] = get_shelf_histogram(sim, presets)
    import NetCDFFile
    % Read parameter and bathymetry data from NetCDF files.
    parameter_file = NetCDFFile.read_parameter_file(sim, presets);
    bathymetry_file = NetCDFFile.read_bathymetry_file(sim.Bathymetry.Number);

    % Pick out data corresponding to shelf points and flatten matrices to
    % vectors. NOTE: Model interpolation for U and V extends the land edge by one grid
    % point. This means some of our shelf values may be NaN.
    % This is a problem with MOM itself and we cannot fix it post-simulation.
    % We are choosing to disregard these cells.
    shelf_data = parameter_file.Data(bathymetry_file.Data<=135 & bathymetry_file.Data > 0 & ~isnan(parameter_file.Data));
    % Get matrix of corresponding cell areas in m^2 (using helper function)
    cell_areas = getCellAreas(parameter_file.LAT_MAX, parameter_file.LAT_MIN, parameter_file.RESOLUTION);
    cell_areas = cell_areas(bathymetry_file.Data<=135 & bathymetry_file.Data > 0 & ~isnan(parameter_file.Data));

    % Create x axis of histogram
    x = (presets.HXMin:presets.HBin:presets.HXMax) + presets.HBin/2.0;

    % Array to hold histogram y-axis data
    y_prime = zeros(1, length(x));

    % Fill histogram bins with appropriate cell areas (y axis of histogram)
    for i = 1:1:length(shelf_data)
        value = shelf_data(i);
        % Find corresponding histogram bin
        k = floor((value-presets.HXMin)/presets.HBin) + 1;
        % Add cell area to histogram bin
        y_prime(k) = y_prime(k)+cell_areas(i);
    end

    % Generate additional statistics
    max_val = max(shelf_data);
    min_val = min(shelf_data);
    total_area = sum(cell_areas);
    weighted_mean = sum(times(cell_areas, shelf_data))/total_area;
    percent_geq_critical = sum(cell_areas(shelf_data >= presets.HXCritical))*100/total_area;

    % Convert y values from raw area counts to percentages
    y = 100.0*y_prime/total_area;
end
