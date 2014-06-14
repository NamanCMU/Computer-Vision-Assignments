clear all
clc

rect = [247,102,285,161];
load bookSequence.mat
box = [];
box = [box;rect];
figure;

for i = 1:size(sequence,4) - 1
    It = im2double(rgb2gray(sequence(:,:,:,i)));
    It1 = im2double(rgb2gray(sequence(:,:,:,i+1)));
    [u,v] = LucasKanadeBasis(It,It1,rect,basis); % Calculating u and v
    %[u,v] = LucasKanade(It,It1,rect); % Calculating u and v
    rect = [rect(1) + u,rect(2) + v, rect(3) + u, rect(4) + v]; % Updating rectangle 
    box = [box;rect]; % Forming box
    imshow(sequence(:,:,:,i));
    hold on;
    rectx = [box(i,1) box(i,3) box(i,3) box(i,1) box(i,1)];
    recty = [box(i,2) box(i,2) box(i,4) box(i,4) box(i,2)];
    plot(rectx,recty,'r');
    % Saving different Frames
%     j = num2str(i);
%     if length(j) == 1
%         k = strcat('00',j);
%     elseif length(j) == 2
%         k = strcat('0',j);
%     else
%         k = j;
%     end
    saveas(gcf,'1.jpeg');
end
saveas(gcf,num2str(248),'jpeg');
save('bookPosition.mat','box'); % Saving the mat file