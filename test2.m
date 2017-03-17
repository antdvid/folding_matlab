clc
clear
close all
points = [0 0 0; 1 0 0; 1 1 0; 0 1 0; -1  1 0; -1 0 0; -1 -1 0; 1 -1 0];
faces = {{2, 3, 4}, {4, 5, 6}, {6, 7}, {7, 8}, {8, 1}}; %points index for faces
creases = [1 2; 1 4; 1 6; 1 7; 1 8]; %points index for creases
edges = [2 3; 3 4; 4 5; 5 6; 6 7; 7 8; 8 2];
rhoT = [-pi/2, pi, -pi/2, pi, pi];
folding(points, edges, creases, faces, rhoT, 200, 'test2.gif')