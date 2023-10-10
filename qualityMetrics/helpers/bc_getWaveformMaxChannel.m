function [maxChannels, nanWaveforms] = bc_getWaveformMaxChannel(templateWaveforms)
% JF, Get the max channel for all templates (channel with largest amplitude)
% ------
% Inputs
% ------
% templateWaveforms: nTemplates × nTimePoints × nChannels single matrix of
%   template waveforms for each template and channel
% ------
% Outputs
% ------
% maxChannels: nTemplates × 1 vector of the channel with maximum amplitude
%   for each template 
% nanWaveforms:  nTemplates × 1 vector. True if waveform contains NaNs for
%   each template. 

 
[~, maxChannels] = max(max(abs(templateWaveforms), [], 2), [], 3);
nanWaveforms =  arrayfun(@(x) any(any(isnan(templateWaveforms(x,:,maxChannels(x))))), 1:size(maxChannels,1));

end