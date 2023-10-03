%% data from Giulia 
% 
load('/home/julie/Dropbox/Data/Shared/Giulia/map_unit117.mat')
load('/home/julie/Dropbox/Data/Shared/Giulia/map_unit134.mat')

waveform_time = 1e3 * ((0:size(map_unit117, 2) - 1) / 30000);


[~, somaLocation] = min(min(map_unit117,[],2));
%maxVal = max(max(abs(map_unit117)));
maxVal = 10;
waveformLimits = [find(waveform_time > 1, 1, 'first'), find(waveform_time > 13, 1, 'first')];
%siteSpacing = 
figure();
hold on;
for iChannel = somaLocation - 10:somaLocation + 50
    if iChannel == somaLocation
        plot(waveform_time(waveformLimits(1):waveformLimits(2)) - waveform_time(waveformLimits(1)), ...
            map_unit117(iChannel, waveformLimits(1):waveformLimits(2)) + maxVal * ...
            (iChannel - somaLocation), 'Color', rgb('Cyan'))

    else
        plot(waveform_time(waveformLimits(1):waveformLimits(2)) - waveform_time(waveformLimits(1)), ...
            map_unit117(iChannel, waveformLimits(1):waveformLimits(2)) + maxVal * ...
            (iChannel - somaLocation), 'Color', 'w')
    end
end
yticks([0, 200, 400])
yticklabels({'0', '400', '800'})
ylabel('distance from soma')
xlabel('time (ms)') 
prettify_plot('','','k');
ylim([-110, 338])
xlim([4, 8])
prettify_addScaleBars([], [], [], [], [], 'ms', 'um');


figure();
colormap(brewermap([], '*RdBu'));
imagesc(flipud(map_unit134))
clim([-20, 20])
