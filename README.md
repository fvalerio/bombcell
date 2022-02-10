# <img style="float: left;" src="https://github.com/Julie-Fabre/bombcell/blob/master/images/bombcell_nobg_blue.png" width=20% height=20%> evaluate unit quality and ephys properties

Bombcell work with units recorded with Neuropixel probes and spike-sorted with kilosort. It classifies the unit into three categories: single units, mutli-units and noise units, with an option to keep or remove non-somatic spikes. `param` is the structure that defines how to compute the quality metrics and which thresholds to use to classify units. We suggest you compute quality metrics with default `param` values, and then adjust the thresholds for your particular neuronal region and needs by looking at distribution histograms of the units' quality metrics and numbers of units removed by each quality metric and individual units in the interactive GUI  See the script `bc_qualityMetrics_pipeline` for an example workflow. 

Used in Peters et al., 2021 to classify striatal units. See the script `bc_selectAndClassifyStriatum` to classify striatal cells as in Peters et al., 2021. 

### Quality metrics 

Run all quality metrics with the function `bc_runAllQualityMetrics`. Eg:

    [qMetric, goodUnits] = bc_runAllQualityMetrics(param, spikeTimes, spikeTemplates, ...
      templateWaveforms, templateAmplitudes,pcFeatures,pcFeatureIdx,usedChannels, savePath);

Set `param.plotThis = 1;` to plot figures for each quality metric (plot examples displayed below), and set `param.plotGlobal = 1;` to plot summary of the noise units' waveforms compared to single multi-units, distribution histograms of the units' quality metrics and numbers of units removed by each quality metric. 

#### somatic

Somatic waveforms are defined as waveforms where the largest trough precedes the largest peak (Deligkaris,Bullmann& Frey, 2016).

#### number of peaks and troughs

Count the number of peaks and troughs to eliminate non-cell-like waveforms due to noise. Right, examples of a unit with a a cell-like waveform (left) and a unit with a noise-like waveform (right). 

<img style="float: right;" src="https://github.com/Julie-Fabre/bombcell/blob/master/images/numberTroughsPeaks.png" width=30% height=30%>

    											
####  % spikes missing 

estimate the percent of spikes missing (false nagatives) by fitting a gaussian the distribution of amplitudes, with a cutoff parameter. This assumes the spike amplitudes follow a gaussian distribution, which is not strictly true for bursty cells, like MSNs. This can then define which epochs of the recording to keep for a unit, if it has for example drifted relative to the recording sites and in only some recording epochs a substantial amount of spikes are missing.

Below: example of unit with many spikes below the detection threshold in the first two time chunks of the recording. 

<img style="float: right;" src="https://github.com/Julie-Fabre/bombcell/blob/master/images/percSpikesMissingDrift.png" width=30% height=30%>

#### number of spikes 

Number of spikes over the recording. Below a certain amount of spikes, ephys properties like ACGs will not be reliable. A good minimum to use is 300 empirically, because Kilosort2 does not attempt to split any clusters that have less than 300 spikes in the post-processing phase.


#### refractory period violations

Estimate fraction of refractory period violations (false positives) using  r = 2*(tauR - tauC) * N^2 * (1-Fp) * Fp / T , solving for Fp, with tauR the refractory period, tauC the censored period, T the total experiment duration, r the number of refractory period violations, Fp the fraction of contamination. method from Hill et al., 2011. 

Below: examples of a unit with a small fraction of refractory period violations (left) and one with a large fraction (right).

<img style="float: right;" src="https://github.com/Julie-Fabre/bombcell/blob/master/images/rpv.png" width=60% height=60%>


#### amplitude 

Amplitude of the mean raw waveformelfor a unit, to eliminate noisy, further away units, that are more likely to be MUA. 

Below: examples of a unit with high amplitude (blue) and one with low amplitude (red).

<img style="float: right;" src="https://github.com/Julie-Fabre/bombcell/blob/master/images/amplitude.png" width=60% height=60%>


#### distance metrics  

Compute measure of unit isolation quality: the isolation distance (see Harris et al., 2001), l-ratio (see Schmitzer-Torbert and Redish, 2004) and silhouette-score (see Rousseeuw, 1987). 

Below: examples of a unit with high isolation distance (left) and one with low isolation distance (right).

<img style="float: right;" src="https://github.com/Julie-Fabre/bombcell/blob/master/images/isolationDistance.png" width=60% height=60%>


#### 

### Quality metrics' GUI guide 

Plot a GUI to flip through the quality metrics for each cell with the function `bc_unitQualityGUI` Eg:

    bc_unitQualityGUI(memMapData, ephysData, qMetrics, param, probeLocation)
    
### Ephys properties

work in progress

#### post spike suppression 

#### waveform duration

#### proportion long ISIs 

## Dependancies:

- https://github.com/kwikteam/npy-matlab (to load data in)

- https://github.com/buzsakilab/buzcode, modified from http://www.fieldtriptoolbox.org/ (to compute fast ACG/CCGs. download the repo and run compileBuzcode.m)

- https://github.com/tuckermcclure/matlab-plot-big (to plot raw data) 
