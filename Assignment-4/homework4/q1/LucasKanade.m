function [u,v] = LucasKanade(It,It1,rect)
% Compute u and v required to move the patch on Image1 so that it matches
% the template

u = 0;v = 0;
eeta = 0.0001; %Threshold
It = im2double(It);
It1 = im2double(It1);

%Forming the template from It
[meshtx,meshty] = meshgrid(rect(1): rect(3) , rect(2) : rect(4));
Ittemplate = interp2(It,meshtx,meshty);

% Computing gradients on the Template from It
[Txtemp1,Tytemp1] = gradient(Ittemplate);
Tx = Txtemp1(:);
Ty = Tytemp1(:);
gradT = [Tx,Ty];

% Run Iterations
while(1)
    % Performing Interpolation 
    [meshx,meshy] = meshgrid((rect(1) : rect(3)), (rect(2): rect(4)));
    meshx = meshx + u;
    meshy = meshy + v;
    It1patch = interp2(It1,meshx,meshy);
    
    % Computing difference between different frames
    Errortemp = It1patch - Ittemplate;
    Error = Errortemp(:);
    
    % Computing deltap
    deltap = - ((gradT'*gradT)\gradT')*Error;
    u = u + deltap(1);
    v = v + deltap(2);
    deltapmag = sqrt(deltap(1)*deltap(1) + deltap(2)*deltap(2));
    
    % Break if deltapmag is less than the threshold
    if deltapmag < eeta
        break;
    end
end    
end

