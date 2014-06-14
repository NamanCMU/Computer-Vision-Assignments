% Track a car in a video
clear all
clc

rect = [328,213,419,265];
load carSequence.mat
box = [];
box = [box;rect];
figure;

% Considering all the frames of a video
for i = 1:size(sequence,4) - 1
    It = im2double(rgb2gray(sequence(:,:,:,i)));
    It1 = im2double(rgb2gray(sequence(:,:,:,i+1)));
    [u,v] = LucasKanade(It,It1,rect); % Calculating u and v
    rect = [rect(1) + u,rect(2) + v, rect(3) + u, rect(4) + v]; % Updating rectangle 
    box = [box;rect]; % Forming box
    imshow(sequence(:,:,:,i));
    hold on;
    rectx = [box(i,1) box(i,3) box(i,3) box(i,1) box(i,1)];
    recty = [box(i,2) box(i,2) box(i,4) box(i,4) box(i,2)];
    plot(rectx,recty);
    saveas(gcf,'1.jpeg');
end
save('carPosition.mat','box'); % Saving the mat file
