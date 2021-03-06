function [u,v] = LucasKanadeBasis(It,It1,rect,basis)

% Initializing different parameters
u = 0;v = 0;
w = zeros(10,1);

It = im2double(It);
It1 = im2double(It1);
NIter = 1000;
%Forming the template from It
[meshtx,meshty] = meshgrid(rect(1): rect(3) , rect(2) : rect(4));
Ittemplatetemp = interp2(It,meshtx,meshty);
Ittemplate = Ittemplatetemp(:);

% Computing gradients on the Template from It
[Txtemp1,Tytemp1] = gradient(Ittemplatetemp);
Tx = Txtemp1(:);
Ty = Tytemp1(:);
gradT = [Tx,Ty];

j = 1;
alpha = 0.01; % Gradient Descent constant

% Run Iterations
while(j<NIter)
    j = j + 1;
    % Performing Interpolation 
    [meshx,meshy] = meshgrid((rect(1) : rect(3)), (rect(2) : rect(4)));
    meshx = meshx + u;
    meshy = meshy + v;
    It1patchtemp = interp2(It1,meshx,meshy);
    It1patch = It1patchtemp(:);
    
    % Find the basisterm and Error term
    basisterm = w(1)*basis{1}(:) +  w(2)*basis{2}(:) + w(3)*basis{3}(:) + w(4)*basis{4}(:) + w(5)*basis{5}(:) + w(6)*basis{6}(:) + w(7)*basis{7}(:) + w(8)*basis{8}(:) + w(9)*basis{9}(:) + w(10)*basis{10}(:);
    Error = It1patch - Ittemplate;
    Fterm = Error - basisterm;
    Jterm = (norm(Fterm))^2;
    
    % Applying Gradient Descent approach to find w, u and v simultaneously
    for i=1:length(basis)
        w(i) = w(i) + 2*alpha*(Fterm'*basis{i}(:));
    end
    u = u - 2*alpha*(Fterm'*gradT(:,1));
    v = v - 2*alpha*(Fterm'*gradT(:,2));

end    
end


