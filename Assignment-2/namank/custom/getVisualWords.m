 function [wordMap] = getVisualWords(I, filterBank, dictionary)
 
 %Form a wordmap by replacing wach pixel in the image to its  closest word
 %in the dictionary
 
 wordMap = zeros(size(I,1)*size(I,2),1);
 II = im2single(rgb2gray(I));
 [X, D] = vl_dsift(II); % Using dense sift to get a descriptor for the pixels
 X = X(1:2,:);
 X = round(double(X'));
 D = double(D');
 Distmatrix = pdist2(D,dictionary);
 [~,ind] = min(Distmatrix,[],2);
 Changes = sub2ind(size(II),X(:,2),X(:,1)); % Map a matrix coordinate to vector value.
 wordMap(Changes,1) = ind;
 wordMap = reshape(wordMap,size(II,1),size(II,2)); % Reshaping
 end
