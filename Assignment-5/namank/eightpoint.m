function [F] = eightpoint(X,Y,M)
% 8 Point Algorithm

%% Step - 1 - Normalizing the Coordinates - Translating and Scaling the data so that it is centered at origin and the average distance to origin is Sqrt(2)


% Normalizing X

% Translating
Origin = zeros(size(X));
Centroid1 = [sum(X(:,1))./size(X,1) , sum(X(:,2))./size(X,1)];
Xhomo1= [X,ones(size(X,1),1)]';
T1 = [1 0 -Centroid1(1); 0 1 -Centroid1(2) ; 0 0 1];
Xnormtemp1 = (T1*Xhomo1)';
%Centroid1 = [sum(Xnormtemp1(:,1))./size(X,1) , sum(Xnormtemp1(:,2))./size(X,1)]

% Scaling
Xnormtemp2 = [ Xnormtemp1(:,1),Xnormtemp1(:,2)];
Scale1 = sum(sqrt(sum(bsxfun(@minus,Xnormtemp2,Origin).^2,2)))./size(Xnormtemp2,1);
T1(1,:) = T1(1,:).*(M/Scale1);
T1(2,:) = T1(2,:).*(M/Scale1);
Xnorm = (T1*Xhomo1)';
% Xnor = [ Xnorm(:,1),Xnorm(:,2)];
% Scale1 = sum(sqrt(sum(bsxfun(@minus,Xnor,Origin).^2,2)))./size(Xnor,1)

% Normalizing Y

% Translating
Origin = zeros(size(Y));
Centroid1 = [sum(Y(:,1))./size(Y,1) , sum(Y(:,2))./size(Y,1)];
Yhomo1= [Y,ones(size(Y,1),1)]';
T2 = [1 0 -Centroid1(1); 0 1 -Centroid1(2) ; 0 0 1];
Ynormtemp1 = (T2*Yhomo1)';
%Centroid2 = [sum(Ynormtemp1(:,1))./size(Y,1) , sum(Ynormtemp1(:,2))./size(Y,1)]

% Scaling
Ynormtemp2 = [ Ynormtemp1(:,1),Ynormtemp1(:,2)];
Scale2 = sum(sqrt(sum(bsxfun(@minus,Ynormtemp2,Origin).^2,2)))./size(Ynormtemp2,1);
T2(1,:) = T2(1,:).*(M/Scale2);
T2(2,:) = T2(2,:).*(M/Scale2);
Ynorm = (T2*Yhomo1)';
 %Ynor = [ Ynorm(:,1),Ynorm(:,2)];
 %Scale2 = sum(sqrt(sum(bsxfun(@minus,Ynor,Origin).^2,2)))./size(Ynor,1)

%% Linear Least Squares to compute F
for i = 1:size(X,1)
    U(i,:) = [Xnorm(i,1)*Ynorm(i,1), Xnorm(i,1)*Ynorm(i,2), Xnorm(i,1), Xnorm(i,2)*Ynorm(i,1), Xnorm(i,2)*Ynorm(i,2), Xnorm(i,2), Ynorm(i,1), Ynorm(i,2), 1];
end

[eigvector,~] = eig(U'*U);
Fvector = eigvector(:,1);
F = vec2mat(Fvector,3);

%% Enforcing Rank 2 Constraint


[U,S,V] = svd(F);% singular value decomposition
S(3,3) = 0;
Fr = U*S*V';

%% Final

F = T1'*Fr*T2;
F = F';




end

