clear all
clc

load many_corresp.mat
load intrinsics.mat
M = sqrt(2);
pts1 = [x1,y1];
pts2 = [x2,y2];
F = eightpoint(pts1,pts2,M);
M2 = camera2(F,K1,K2,pts1,pts2);
M1 = eye(3,4);
P = triangulate(K1*M1,pts1,K2*M2,pts2);
scatter3(P(:,1),P(:,2),P(:,3),'filled');