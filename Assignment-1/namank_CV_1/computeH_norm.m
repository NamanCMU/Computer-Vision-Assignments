function [H2to1]=computeH_norm(p1, p2)
% Q4.2 - Normalize p1 and p2 before running computeH

% For the unique solution, we need only 4 points for a 2D case. More than 4
% points will give us the right soltion but it will not be unique.
%p1 = p1(:,1:4);
%p2 = p2(:,1:4);

lent = length(p1);
a = ones(lent);
p1 = [p1;a(1,:)];
p2 = [p2;a(1,:)];

% Initial values of Centroid
centx1 = sum(p1(1,:))/lent; 
centy1 = sum(p1(2,:))/lent;
centx2 = sum(p2(1,:))/lent;
centy2 = sum(p2(2,:))/lent;

% Applying transformation to translate centroid of points
Hnorm1 = [ 1 0 -centx1; 0 1 -centy1; 0 0 1];
Hnorm2 = [ 1 0 -centx2; 0 1 -centy2; 0 0 1];
pnew1 = Hnorm1*p1;
pnew2 = Hnorm2*p2;

% Making average distance from origin equal to sqrt(2)
avg1 = sum(sqrt(pnew1(1,:).^2 + pnew1(2,:).^2))/lent;
xx1 = sqrt(2)/avg1;
Hnorm1(1,:) = Hnorm1(1,:).*xx1;
Hnorm1(2,:) = Hnorm1(2,:).*xx1;
pnew11 = Hnorm1*p1;  %Normalized points corresponding to p1

avg2 = sum(sqrt(pnew2(1,:).^2 + pnew2(2,:).^2))/lent;
xx2 = sqrt(2)/avg2;
Hnorm2(1,:) = Hnorm2(1,:).*xx2;
Hnorm2(2,:) = Hnorm2(2,:).*xx2;
pnew22 = Hnorm2*p2; %Normalized points corresponding to p2

%Calling computeH with normalized values of p1 and p2
point1 = pnew11(1:2,:);
point2 = pnew22(1:2,:);
H2to1norm = computeH(point1,point2);
H2to1 = Hnorm1\(H2to1norm*Hnorm2); % For images we cant use normalized H so we have to convert it back to un-normalized H (inverse normalization).
end
