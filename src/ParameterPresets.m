% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

classdef ParameterPresets
    properties
        CMax          % COLORBAR MAXIMUM
        CMin          % COLORBAR MINIMUM
        CRange        % = [CMin CMax]
        CTicks        % = (CMin:CTickSpacing:CMax)
        CTickSpacing  % SPACING BETWEEN COLORBAR AXIS TICKS
        HBin          % HISTOGRAM BIN SIZE
        HXCritical    % HISTOGRAM X CRITICAL VALUE
        HXMax         % MAX HISTOGRAM X VALUE
        HXMin         % MIN HISTOGRAM X VALUE
        HXRange       % = [HXMin HXMax]
        HXTickFormat  % FORMATS DECIMAL VALUES (EXAMPLE: '%.0f')
        HXTicks       % = (HXMin:HXTickSpacing:HXMax)
        HXTickSpacing % SPACING BETWEEN HISTOGRAM X AXIS TICKS
        HYMax         % MAX HISTOGRAM Y VALUE
        HYMin         % MIN HISTOGRAM Y VALUE
        HYRange       % = [HYMin HYMax]
        HYTickLabels  % Y AXIS LABELS FOR HISTOGRAM
        Name          % SHORT NAME FOR THIS PARAMETER (USED IN FILENAME)
        NCName        % NAME USED TO IDENTIFY PARAMETER IN NC FILES (COULD EQUAL ShortName)
        Units         % UNITS THIS PARAMETER IS MEASURED IN
    end
    methods
        function obj = ParameterPresets(name, nc_name, units, cmin, ctick_spacing, cmax, hbin, hxmin, hxcritical, hxmax, hxtick_spacing, hxtick_format, hymin, hymax, hytick_labels)
            obj.CMax = cmax;
            obj.CMin = cmin;
            obj.CRange = [cmin cmax];
            obj.CTicks = (cmin:ctick_spacing:cmax);
            obj.CTickSpacing = ctick_spacing;
            obj.HBin = hbin;
            obj.HXCritical = hxcritical;
            obj.HXMax = hxmax;
            obj.HXMin = hxmin;
            obj.HXRange = [hxmin hxmax];
            obj.HXTickFormat = hxtick_format;
            obj.HXTicks = (hxmin:hxtick_spacing:hxmax);
            obj.HXTickSpacing = hxtick_spacing;
            obj.HYMax = hymax;
            obj.HYMin = hymin;
            obj.HYRange = [hymin hymax];
            obj.HYTickLabels = hytick_labels;
            obj.Name = name;
            obj.NCName = nc_name;
            obj.Units = units;
        end
    end
    methods (Static)
        function obj = by_name(name)
            switch name
                case 'SSH_Amp'
                    obj = ParameterPresets(name, 'AMP_PREV_M2', 'm', 0, 0.5, 1.5, 0.10, 0, 1.4, 5.5, 1.0, '%.1f', 0.001, 30, {'0.001', '0.01', '0.1', '1', '10'});
                case 'A'
                    obj = ParameterPresets(name, name, 'm/s', 0, 0.225, 0.45, 0.02, 0, 0.3, 2.4, 0.2, '%.1f', 0.0001, 30, {'0.0001', '0.001', '0.01', '0.1', '1', '10'});
                case 'U_Amp'
                    obj = ParameterPresets(name, name, 'm/s', 0, 0.2, 0.4, 0.02, 0, 0.28, 0.9, 0.1, '%.1f', 0.0001, 30, {'0.0001', '0.001', '0.01', '0.1', '1', '10'});
                case 'V_Amp'
                    obj = ParameterPresets(name, name, 'm/s', 0, 0.2,  0.4, 0.02, 0, 0.16, 0.8, 0.1, '%.1f', 0.0001, 30, {'0.0001', '0.001', '0.01', '0.1', '1', '10'});
                case 'S'
                    obj = ParameterPresets(name, name, 'log_1_0(s^3/m^2)', 0, 6, 12, 0.2, -1, 2.7, 17, 1, '%.0f', 0.0001, 30, {'0.0001', '0.001', '0.01', '0.1', '1', '10'});
            end
        end
    end
end
