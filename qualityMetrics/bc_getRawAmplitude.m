function rawAmplitude = bc_getRawAmplitude(rawWaveforms, rawFolder)
% JF, Get the amplitude of the mean raw waveform for a unit 
% ------
% Inputs
% ------
% rawWaveforms: nTimePoints × 1 double vector of the mean raw waveform
%   for one unit
% rawFolder: string containing the location of the raw .bin or .dat file.
% ------
% Outputs
% ------
% rawAmplitude: raw amplitude in microVolts of the mean raw wwaveform for
% this unit 
% 
if iscell(rawFolder)
    rawFolder = fileparts(rawFolder{1});
end
spikeFile = dir(fullfile(rawFolder, '*.ap.bin')); % spikeGLX format 
if isempty(spikeFile)
    spikeFile = dir(fullfile(rawFolder, '*.dat')); %openEphys format 
    metaFileDir = dir([rawFolder, '/../../*.oebin']);
    scalingFactor = bc_readOEMetaFile(metaFileDir);
    
    
else
    % 1.0 or 2.0? 
    metaFileDir = dir([rawFolder, '/*.ap.meta']);
    scalingFactor = bc_readSpikeGLXMetaFile(metaFileDir);
end
rawWaveforms = rawWaveforms .* scalingFactor;
rawAmplitude = abs(max(rawWaveforms)) + abs(min(rawWaveforms));
end

