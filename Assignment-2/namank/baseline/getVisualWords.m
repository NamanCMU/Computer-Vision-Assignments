function [wordMap] = getVisualWords(I, filterBank, dictionary)

%Form a wordmap by replacing wach pixel in the image to its  closest word
%in the dictionary

wordMap = zeros(size(I,1)*size(I,2),1);
[filterResponses] = extractFilterResponses(I, filterBank);
Distmatrix = pdist2(filterResponses,dictionary);
[~,ind] = min(Distmatrix,[],2); % Finding the index of the closest Visual Word.
inds = (1:(size(I,1)*size(I,2)))';
wordMap(inds) = ind; % Forming the wordmap
wordMap = reshape(wordMap,size(I,1),size(I,2)); % Reshaping wordmap to match size of image I.
end

