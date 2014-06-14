function [H2to1] =computeH(p1, p2)
% Q4.1 - Finding the homography

% For the unique solution, we need only 4 points for a 2D case. More than 4
% points will give us the right soltion but it will not be unique.
%p1 = p1(:,1:4);
%p2 = p2(:,1:4);

% Adding a row of one to convert to homogenous coordinates
lent = length(p1);
a = ones(lent);
p1 = [p1;a(1,:)];
p2 = [p2;a(1,:)];

% Converting to a form A*h = 0
A = [];
for i=1:lent
    A = [A;p2(:,i)' [0,0,0] -p1(1,i)*p2(:,i)'; [0,0,0] p2(:,i)' -p1(2,i)*p2(:,i)'];
end
% Finding eigen vector corresponding to the minimum eigen value of(A'*A).
C = A'*A;
[D,~] = eig(C);
H2to1vect = D(:,1);

% Reshaping the vector to form a H matrix
H2to1 = vec2mat(H2to1vect,3);
end