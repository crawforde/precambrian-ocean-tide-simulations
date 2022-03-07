% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

classdef Simulation
    properties
        Number     % SIMULATION # (STRING)
        Run        % WHICH SIMULATION RUN TO ANALYZE (0, 1, 2, OR 3)
        Bathymetry % BATHYMETRY OBJECT FOR THIS SIMULATION
    end
    methods
        function obj = Simulation(number, run, bathymetry)
            import Bathymetry
            obj.Number = number;
            obj.Run = run;
            obj.Bathymetry = bathymetry;
        end
    end
    methods (Static)
        function obj = by_number(number)
            import Bathymetry
            switch number
                case 1
                    obj = Simulation('1', '3', Bathymetry.by_number(1));
                case 2
                    obj = Simulation('2', '3', Bathymetry.by_number(1));
                case 3
                    obj = Simulation('3', '3', Bathymetry.by_number(2));
                case 4
                    obj = Simulation('4', '3', Bathymetry.by_number(3));
                case 5
                    obj = Simulation('5', '3', Bathymetry.by_number(4));
                case 6
                    obj = Simulation('6', '3', Bathymetry.by_number(4));
                case 7
                    obj = Simulation('7', '3', Bathymetry.by_number(5));
                case 8
                    obj = Simulation('8', '3', Bathymetry.by_number(6));
                case 9
                    obj = Simulation('9', '3', Bathymetry.by_number(7));
                case 10
                    obj = Simulation('10', '3', Bathymetry.by_number(8));
                case 11
                    obj = Simulation('11', '3', HYCOMBathymetry());
            end
        end
        function arr = list_all()
            s1 = Simulation.by_number(1);
            s2 = Simulation.by_number(2);
            s3 = Simulation.by_number(3);
            s4 = Simulation.by_number(4);
            s5 = Simulation.by_number(5);
            s6 = Simulation.by_number(6);
            s7 = Simulation.by_number(7);
            s8 = Simulation.by_number(8);
            s9 = Simulation.by_number(9);
            s10 = Simulation.by_number(10);
            s11 = Simulation.by_number(11);
            arr = [s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11];
        end
        function arr = list_primary()
            s1 = Simulation.by_number(1);
            s5 = Simulation.by_number(5);
            s7 = Simulation.by_number(7);
            s8 = Simulation.by_number(8);
            s9 = Simulation.by_number(9);
            s10 = Simulation.by_number(10);
            s11 = Simulation.by_number(11);
            arr = [s1 s5 s7 s8 s9 s10, s11];
        end
    end
end
