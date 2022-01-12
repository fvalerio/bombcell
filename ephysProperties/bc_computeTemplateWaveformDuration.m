function templateDuration = bc_computeTemplateWaveformDuration(thisWaveform,...
        ephys_sample_rate)

    minProminence = 0.2 * max(abs(squeeze(thisWaveform)));

    [PKS, LOCS] = findpeaks(squeeze(thisWaveform), 'MinPeakProminence', minProminence);
    [TRS, LOCST] = findpeaks(squeeze(thisWaveform)*-1, 'MinPeakProminence', minProminence);
    if isempty(TRS)
        TRS = min(squeeze(thisWaveform));
        if numel(TRS) > 1
            TRS = TRS(1);
        end
        LOCST = find(squeeze(thisWaveform) == TRS);
    end
    if isempty(PKS)
        PKS = max(squeeze(thisWaveform));
        if numel(PKS) > 1
            PKS = PKS(1);
        end
        LOCS = find(squeeze(thisWaveform) == PKS);
    end

    peakLoc = LOCS(PKS == max(PKS));
    if numel(peakLoc) > 1
        peakLoc = peakLoc(1);

    end
    troughLoc = LOCST(TRS == max(TRS));
    if numel(troughLoc) > 1
        troughLoc = troughLoc(1);
    end


    templateDuration = (peakLoc - troughLoc) / ephys_sample_rate * 1e6;
end