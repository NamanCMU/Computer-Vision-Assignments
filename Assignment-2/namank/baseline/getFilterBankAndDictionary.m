function [ filterBank, dictionary] = getFilterBankAndDictionary( imPaths)
% Generate a dictionary using the list of images given.

alpha = 100; %Number of random points selected from each image.
K = 100; % Number of Visual Words.
[filterBank] = createFilterBank(); % load filterBank
filterResponses = [];

% Generate filter responses
for i=1:length(imPaths)
    I = imread(imPaths{i});
    [filterResponsestemp] = extractFilterResponses(I, filterBank); % extract filter-reponses
    alphaval = randperm(size(filterResponsestemp,1),alpha);
    filterResponsestemp = filterResponsestemp(alphaval,:);
    filterResponses = [filterResponses;filterResponsestemp];
end

% Use K-means to find dictionary
[~, dictionary] = kmeans(filterResponses,K,'EmptyAction','drop');


