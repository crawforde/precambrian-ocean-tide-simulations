% Copyright (C) 2022 University of Michigan
%
% Contact: Eliana Crawford <crawforde@kenyon.edu>, Brian Arbic <arbic@umich.edu>
%
% This source is subject to the license found in the file 'LICENSE'
% which must be be distributed together with this source. All other
% rights reserved.

classdef PlotTools
    methods (Static)
        function plot_text = add_plot_text(x, y, words)
            plot_text = text(x, y, words, 'Units', 'normalized', 'fontsize', 20);
        end
        function fig = create_default_figure(varargin)
            pos = [100 600 1000 800];
            if nargin == 0
                fig = figure('pos', pos);
            else
                name = varargin{1};
                if nargin > 1
                    pos = varargin{2};
                end
                fig = figure('Name', name, 'NumberTitle', 'off', 'pos', pos);
            end
        end
        function cb = create_standalone_colorbar(cbaxis, cbtick)
            ax = axes;
            cb1 = colorbar(ax);
            set(ax, 'Visible', 'off');
            set(cb1, 'Location', 'west');
            caxis(cbaxis);
            set(cb1,'YTick', cbtick);
            cb = cb1;
        end
        function plot = plot_parameter(presets, file)
            plot1 = imagesc(file.Lon, file.Lat, file.Data);
            axis([file.LON_MIN file.LON_MAX file.LAT_MIN file.LAT_MAX]);
            set(gca,'YDir','normal');
            set(gca, 'XTick', file.LON_TICKS);
            set(gca, 'YTick', file.LAT_TICKS);
            caxis(presets.CRange);
            plot = plot1;
        end
        function log_plot = plot_log_histogram(x, y, presets, weighted_mean)
            log_plot0 = bar(x, y);
            line([presets.HXCritical presets.HXCritical], presets.HYRange,'Color', 'cyan', 'LineWidth', 2, 'LineStyle', '--');
            line([weighted_mean weighted_mean], presets.HYRange,'Color', 'green', 'LineWidth', 2);
            setting_names = {'Box','XLim','XTick','TickDir', 'YLim', 'YTickLabel'};
            setting_values = {'off', presets.HXRange, presets.HXTicks, 'out', presets.HYRange, presets.HYTickLabels};
            set(gca, setting_names, setting_values);
            grid on;
            tix=get(gca,'xtick')';
            set(gca,'xticklabel',num2str(tix, presets.HXTickFormat));
            set(gca, 'YScale', 'log');
            log_plot = log_plot0;

        end
        function save_image(fig, image_path)
            import PathTools;
            set(fig, 'PaperPositionMode', 'auto');
            pause(3);
            print(fig, PathTools.gen_path(['/images' image_path]), '-dpng', '-r0');
        end
        function set_global_defaults(varargin)
            default_font_size = 30;
            if nargin > 0
                default_font_size = varargin{1};
            end
            set(0, 'defaultAxesFontName', 'Times New Roman');
            set(0, 'defaultTextFontName', 'Times New Roman');
            set(0, 'defaultAxesFontSize', default_font_size);
            set(0, 'DefaultFigureVisible','on');
        end
    end
end
