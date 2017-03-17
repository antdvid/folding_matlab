clc
clear
close all
theta = linspace(0, 2*pi - 2*pi/ 16, 16);
points = [cos(theta)' sin(theta)' zeros(16, 1)]*2;
points = [points; 0 0 0];
edges = [1 : 16; 2 : 16, 1]';
faces = {{1, 2}, {2, 3},{3, 4}, {4, 5}, {5, 6}, {6, 7}, {7, 8}, {8,9}, ...
    {9,10}, {10, 11}, {11, 12}, {12, 13}, {13, 14},...
    {14, 15}, {15, 16}, {16, 1}}; %points index for faces
creases = [ones(1, 16) * 17; 1:16]'; %points index for creases
rhoT = [-pi, 3*pi/4, -pi, 3*pi/4, -pi, 3*pi/4, -pi, 3*pi/4, -pi, ...
    3*pi/4, -pi, 3*pi/4, -pi, 3*pi/4, -pi, 3*pi/4];
xlim([-2 2])
ylim([-2 2])
zlim([-2 2])
view([74 12])
rho_series = folding_opt(points, edges, creases, faces, rhoT, 800, 'test3.gif');

figure(2)
plot(rho_series(rho_series(:,1) ~= 0, :), '-')
axis tight
ax = gca;
set(gca, 'Ytick', [-3/2*pi -pi -pi/2 0 pi/2 pi 3/2*pi]);
set(gca, 'YTickLabel', {'-3/2\pi','-\pi','-\pi/2','0','\pi/2','\pi','3/2\pi'});
ylim([-pi pi]*1.2)