% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

%   DESCRIPTION:
%   This function creates an array of grid cell areas corresponding to a
%   bathymetry with the given northernmost and southernmost latitudes
%   (assumes the bathymetry covers all longitudes).
%
%   ARGUMENTS:
%   north_lat_degrees - the northernmost latitude on the map, in degrees
%
%   south_lat_degrees - the southernmost latitude on the map, in degrees
%
%   resolution - map vertical resolution, in degrees
%
%   RETURN TYPE:
%   The function returns a 2 dimensional array of cell areas, in meters
%   squared. The array has the same dimensions as the corresponding
%   bathymetry.

function cell_areas = getCellAreas(north_lat_degrees,south_lat_degrees,resolution)
latitudes = [south_lat_degrees:resolution:north_lat_degrees];
EARTH_RADIUS = 6371000;
lon_length = 360.0/resolution;
lat_length = length(latitudes);
cell_areas = zeros(lat_length,lon_length);
dy = 2*pi*EARTH_RADIUS*resolution/360.0;
for m = 1:lat_length
    dx = dy*cosd(latitudes(m));
    cell_areas(m,:) = dx*dy;
    clear dx;
end
