load bookSequence.mat
It = im2double(rgb2gray(sequence(:,:,:,1)));
It1 = im2double(rgb2gray(sequence(:,:,:,2)));
rect = [247,102,285,161];

[u,v] = LucasKanadeBasis(It,It1,rect,basis);