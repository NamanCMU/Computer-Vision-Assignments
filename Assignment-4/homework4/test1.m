load carSequence.mat
It = im2double(rgb2gray(sequence(:,:,:,1)));
It1 = im2double(rgb2gray(sequence(:,:,:,2)));
rect = [328,213,419,265];

[u,v] = LucasKanade(It,It1,rect);