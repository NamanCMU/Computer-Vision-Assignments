clear
clc

load traintest.mat

% Create a cell classifier_op which contains the predicted label(name) of all 
% the test images

toProcess1 = strcat([cd,'/images/'],imTss);
 for i = 1:length(imTss)
     classifier_op{i} = guessImage(toProcess1{i});
 end
 
 
% Computing Confusion Matrix
eachlabelsize = round(length(imTss)./length(mapping));
  start = 1; ends = 1;
  cm = zeros(length(mapping),length(mapping));
  for i = 1:length(mapping)
      cm(i,:) = cellfun(@(x) sum(ismember(classifier_op(start:ends*eachlabelsize),x)), mapping);
      start = ends*eachlabelsize + 1;
      ends = ends + 1;
  end

% Printing Confusion Matrix and accuracy
Confusion_Matrix = cm
Accuracy = trace(cm)/sum(cm(:))