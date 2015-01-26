% This is a function that samples a normal random variable, in the format of simopt.
% alt(1) is the mean, and alt(2) is the standard deviation.
function y = normal(alt, runlength, seed, other)
    m = alt(1); % mean
    sdev = alt(2); % standard deviation
    Stream = RandStream.create('mrg32k3a', 'NumStreams', 1);
    Stream.Substream = seed;
    OldStream = RandStream.setGlobalStream(Stream);
    y = normrnd(m, sdev);
    RandStream.setGlobalStream(OldStream); % Restore previous stream
