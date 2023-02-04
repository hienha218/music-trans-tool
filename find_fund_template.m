function frequency_estimate = find_fund_template(signal, fs)
    N = 8000;  % fft size
    x = signal(floor(length(signal)/4):end);    % ignoring the attack
    spectrum = fft(x, N);     
    spectrum = abs(spectrum(1:end/2)); % could zero-padding for higher resolution
    
    f = (0:N/2-1)*fs/N; % freq of every freq bin in 1 frame
    %bar(f, abs(spectrum(1:N/2)));
    corr = [];
    
    low_freq_bin = length(find(f <= 100)); % will change depends on instruments
    high_freq_bin = length(find(f <= 3520)); % same with this
    
    for bin = low_freq_bin:high_freq_bin
        template = zeros(size(spectrum));
        h = 1;
        template(bin) = h;
        
        i = 2;
        harmonic_bin = length(find(f<=f(bin)*i));
        for h = 1:25
           %h = h * 0.03;
           template(harmonic_bin) = 1/h;    % can tweak this to change the decay pattern
                                            % refer to the spectrum
           i = i + 1;
           harmonic_bin = length(find(f<=f(bin)*i));
        end

        a = corrcoef(spectrum, template);
        corr(bin) = a(1, 2);
    end

    emp_template = zeros(size(spectrum));
    a = corrcoef(spectrum, emp_template);
    
    if a(1,2) > max(corr)
        frequency_estimate = 0;
    else
        frequency_estimate = f(find(corr == max(corr), 1));
    end
    
end