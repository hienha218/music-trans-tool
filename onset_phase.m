% onset detection method using phase
function onsets = onset_phase(sig, fs, m, overlap_size, nfft, instrument, delta)
    if (~exist('delta', 'var'))
        % pitched percussive
        if instrument == "PP"
            delta = 0.38;
        % pitched non percussive
        elseif instrument == "PNP"
            delta = 0.16;
        % non-pitched percussive
        elseif instrument == "NPP"
            delta = 0.16;
        end
    end
    [S, ~, T] = stft(sig, fs, 'Window', hann(m), 'OverlapLength', overlap_size, FFTLength=nfft);
    % abs(S) gives amplitude ==> spectrogram, angle(S) gives phase
    distances = zeros(size(S));
    phases = unwrap(angle(S));

    for i = 3:size(S, 2)-1
        phase_diff = phases(:,i) - 2.*(phases(:,i-1)) + phases(:,i-2);
        dist = (abs(S(:, i-1)).^2 + abs(S(:, i)).^2 - 2.*abs(S(:, i-1)).*abs(S(:, i)).*cos(phase_diff)).^0.5;
        distances(:, i) = dist;
    end
    distances = sum(distances, 1);
    % normalize
    j = max(distances);
    distances = distances./j;
    peaks = find_peaks(distances, floor((m-overlap_size)/2), 0.2, delta);
    peak_idx = find(peaks == 1);

    onsets = T(peak_idx);
end

function peaks = find_peaks(x, min_distance, thres_scale, delta)
    peaks = zeros(1,length(x));
    i_prev = -min_distance;
    for i=2:length(x) - 1
        if x(i - 1) < x(i) && x(i) > x(i + 1)
            % threshold using median filter
            thr = delta + thres_scale*median(x(max(1,i-min_distance):min(length(x), i+min_distance)));
            if x(i) >= thr && i > i_prev + min_distance
                peaks(i) = 1;
                i_prev = i;
            end
        end
    end
end
