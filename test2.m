clc
clear
close all
points = [0 0 0; 1 0 0; 1 1 0; 0 1 0; -1  1 0; -1 0 0; -1 -1 0; 1 -1 0];
faces = {{2, 3, 4}, {4, 5, 6}, {6, 7}, {7, 8}, {8, 1}}; %points index for faces
creases = [1 2; 1 4; 1 6; 1 7; 1 8]; %points index for creases
edges = [2 3; 3 4; 4 5; 5 6; 6 7; 7 8; 8 2];
rhoT = [-pi/2, pi, -pi/2, pi, pi];
zlim([-2 2])
xlim([-2 2])
ylim([-2 2])
view([0 66])
rho_series = folding_opt(points, edges, creases, faces, rhoT, 130, 'test2.gif');

figure(2)
plot(rho_series(rho_series(:,1) ~= 0, :), '-')
axis tight
ax = gca;
set(gca, 'Ytick', [-3/2*pi -pi -pi/2 0 pi/2 pi 3/2*pi]);
set(gca, 'YTickLabel', {'-3/2\pi','-\pi','-\pi/2','0','\pi/2','\pi','3/2\pi'});
ylim([-1.2*pi 1.2*pi])