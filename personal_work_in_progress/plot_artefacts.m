% for noise units plot waveform over each channel 


noiseUnits = find(unitType == 0 | unitType > 0);
channelPositions_x = repmat([43,11,59,27], 1, 96);
channelPositions_y = sort(repmat(0:20:3820, 1, 2));

waveform_time = 1e3 * ((0:size(rawWaveformsFull, 3) - 1) / 30000);
scaleF = [repmat(1, 100, 1); 2];
figure('Color', 'k');
noiseUnits_idx = 1:numel(unitType);%[6,20,21,23,27]+1;%1:numel(noiseUnits);%[2,21,25,11];
for idx = 1:numel(noiseUnits_idx)
    iNoiseUnit = noiseUnits(noiseUnits_idx(idx));
    figure();%subplot(1,numel(noiseUnits_idx),idx)
    hold on;
    set(gca, 'color', 'k');
    for iChannel = 1:size(channelPositions,1)
        plot(channelPositions_x(iChannel)./6 + waveform_time, ...
            squeeze(rawWaveformsFull(qMetric.phy_clusterID == iNoiseUnit,iChannel,:))* scaleF(idx) + ...
            (channelPositions_y(iChannel) ), 'Color', 'w')
    end
    xlim([1.8, 12.6])
    ylim([-110, 3600])
end
 prettify_plot('','','k');
 for idx = 1:numel(noiseUnits_idx)
    subplot(1,numel(noiseUnits_idx),idx)
    prettify_addScaleBars([], [], [], [], [], 'ms', 'um');
 end


%% noiseUnits 2, 11, 21, 25 bc_qualityMetricsPipeline_JF('JF093','2023-03-06',1,[],1,[],1,1,1)
%% noiseUnits 1,5,8,9,11,bc_qualityMetricsPipeline_JF('JF093','2023-03-07',1,[],1,[],1,1,1)
%% 6, 20, 21, 23, 27