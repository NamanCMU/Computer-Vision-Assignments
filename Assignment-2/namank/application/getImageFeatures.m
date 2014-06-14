function [ h ] = getImageFeatures(wordMap,dictionarySize )

% Finding the histogram telling how often each visual word appears in the
% image.

range = 1: dictionarySize;
h = histc(wordMap(:),range); % Using Hist Count
h = h./norm(h,1); % L1 Normalization

end
