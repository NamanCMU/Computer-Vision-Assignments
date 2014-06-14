clear
clc

load traintest.mat

% Create a cell classifier_op which contains the predicted label(name) of all 
% the test images
classifier_op = [];
toProcess1 = strcat([cd,'/images/'],imTss);
 for i = 1:length(toProcess1)
      M  = guessImage(toProcess1{i});
      if strcmp(M,mapping{1}) classifier_op_temp = 1;end
      if strcmp(M,mapping{2}) classifier_op_temp = 2;end
      if strcmp(M,mapping{3}) classifier_op_temp = 3;end
      if strcmp(M,mapping{4}) classifier_op_temp = 4;end
      if strcmp(M,mapping{5}) classifier_op_temp = 5;end
      if strcmp(M,mapping{6}) classifier_op_temp = 6;end
      if strcmp(M,mapping{7}) classifier_op_temp = 7;end
      if strcmp(M,mapping{8}) classifier_op_temp = 8;end
      classifier_op = [classifier_op;classifier_op_temp];
 end
 
% Computing Confusion Matrix

% 1st Method
cm = confusionmat(csTss,classifier_op);

% 2nd Method
%   eachlabelsize = round(length(imTss)./length(mapping));
%   start = 1; ends = 1;
%   cm = zeros(length(mapping),length(mapping));
%   for i = 1:length(mapping)
%       cm(i,:) = cellfun(@(x) sum(ismember(classifier_op(start:ends*eachlabelsize),x)), mapping);
%       start = ends*eachlabelsize + 1;
%       ends = ends + 1;
%   end

% Printing Confusion Matrix and accuracy
Confusion_Matrix = cm
Accuracy = trace(cm)/sum(cm(:))
