function [compareX,compareY] = makeTestPattern(patchWidth, nbits)
% Creating a set of Brief Tests

totalpts = patchWidth*patchWidth;
[compareX] = ceil(rand(nbits,1)*totalpts);
[compareY] = ceil(rand(nbits,1)*totalpts);
save('testpattern.mat','compareX','compareY','patchWidth'); % Saving the mat file


end

