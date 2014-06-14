function [ histInter ] = distanceToSet(wordHist, histograms)
%Find histogram intersection similarity

histInter = sum(bsxfun(@min,wordHist,histograms));

end

