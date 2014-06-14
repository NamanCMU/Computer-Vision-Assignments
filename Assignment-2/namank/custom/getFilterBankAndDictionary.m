 function [ filterBank, dictionary] = getFilterBankAndDictionary( imPaths)
% Generate a dictionary using the list of images given.
 
 K = 100;
 
 [filterBank] = createFilterBank(); % load filterBank
 Responses = [];
 % Using SIFT instead of Filter Responses to create a Dictionary. So, it
 % will give us a K*128 dimensional dictionary instead of K*99 in case of
 % Filter Responses.
 for i=1:length(imPaths)
     I = imread(imPaths{i});
     II = im2single(rgb2gray(I));
     [~, D] = vl_sift(II);
     D = double(D');
     Responses = [Responses;D];
 end
 
 % Use K-means to get dictionary
 [~, dictionary] = kmeans(Responses,K,'EmptyAction','drop');
