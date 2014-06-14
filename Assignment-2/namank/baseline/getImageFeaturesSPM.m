function [h] = getImageFeaturesSPM(layerNum,wordMap,dictionarySize)
% Calcuate a multi-resolution represntation

[rows,columns] = size(wordMap);
block_final_image = cell(0,0);
h = [];
weight = [];
% Divide an image into cells. For example : for layer 1, divide it into 4
% cells and for layer 2 and we are considering only layers 0,1,2.
for i = (layerNum - 1):-1:0
    weights = 0;
    % Dividing the image into sub images.
    layerx = power(2,i);
    layery = power(2,i);
    rows_cell = floor(rows./layerx);
    columns_cell = floor(columns./layery);
    blockvector1 = [rows_cell * ones(1,layerx), rem(rows,rows_cell)];
    blockvector2 = [columns_cell * ones(1,layery), rem(columns,columns_cell)];
    block_image = mat2cell(wordMap,blockvector1,blockvector2);
    block_image = block_image(1:layerx,1:layery);
    block_image = block_image(:); 
    % Calculating Weights for each layer
    if i == 0
        weights(1:length(block_image)) = power(2,-2);
    elseif i == 1
        weights(1:length(block_image)) = power(2,-2);
    else
        weights(1:length(block_image)) = power(2,i-(layerNum-1)-1);
    end
    weight = [weight;weights']; % Concatinating all the weights
    block_final_image = [ block_final_image;block_image]; % Concatenation of all sub-images
    
end

% COmpute Histograms for all the cells and then concatenate them to form a
% multi-resolution representation of the image.
for i = 1 : length(block_final_image)
    H = weight(i).*getImageFeatures(block_final_image{i},dictionarySize);
    h = [h;H]; % Concatinating the histograms
end
h = h./norm(h,1); % Normalize h
end

