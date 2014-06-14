function [M] = LucasKanadeAffine(It,It1)
% This will find the affine transformation matrix for two input images It
% and It1


% Converting images to double
It = im2double(It);
It1 = im2double(It1);

output = [0;0;0;0;0;0];
Itoriginal = It;
Threshold = 0.0001;

%Finding Gradients
[Tx,Ty] = gradient(It);
mag = 100;
    
 while(mag > Threshold)

    M = [1 + output(1), output(3), output(5); output(2), 1 + output(4), output(6); 0, 0, 1]; % M Matrix
    It_wa = warpH(Itoriginal,inv(M),size(Itoriginal)); % Warping Itoriginal
    
    % Only consider overlapping area between two images
    newindex = find(It_wa~=0);
    Error = It1(newindex) - It_wa(newindex);
    
    Tx_trtemp = warpH(Tx,inv(M),size(Itoriginal));  
    Ty_trtemp = warpH(Ty,inv(M),size(Itoriginal));  
    Tx_tr = Tx_trtemp(newindex);
    Ty_tr = Ty_trtemp(newindex);
    
    SDI = zeros(size(newindex,1),6); 
    
    [row,col] = ind2sub(size(Itoriginal),newindex);
    % Find Jacobian
    for i = 1:size(newindex,1)
        y = row(i);
        x = col(i);
        SDI(i,:) = [Tx_tr(i), Ty_tr(i)]*[ x 0 y 0 1 0;0 x 0 y 0 1];
    end
    
    % Find Hessian Matrix and deltap
    Hessian = SDI'*SDI;
    outputtemp = Hessian\(SDI'*Error);
    output = output + outputtemp;
    mag = norm(outputtemp); % magnitude of deltap
    JTerm = (norm(SDI*outputtemp + Error)).^2; % Term to be minimized
    
 end
 M = inv(M);
 
end


function warp_im = warpH(im, H, out_size,fill_value)

if ~exist('fill_value', 'var') || isempty(fill_value)
    fill_value = 0;
end

tform = maketform( 'affine', H'); 
warp_im = imtransform( im, tform, 'bilinear', 'XData', [1 out_size(2)], 'YData', [1 out_size(1)], 'Size', out_size(1:2), 'FillValues', fill_value*ones(size(im,3),1));

end

