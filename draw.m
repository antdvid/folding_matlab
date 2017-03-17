function draw(points, edges, creases)
hold on
for i = 1 : size(edges, 1)
    i1 = edges(i,1);
    i2 = edges(i,2);
    plot3([points(i1,1) points(i2,1)], [points(i1,2) points(i2,2)], ...
          [points(i1,3) points(i2,3)], 'ob-','markerfacecolor', 'b',...
          'markersize', 5, 'linewidth', 2)
end

for i = 1 : size(creases, 1)
    vindex = creases(i, 1);
    pindex = creases(i, 2);
    plot3([points(vindex,1) points(pindex,1)], [points(vindex,2) points(pindex, 2)], ...
    [points(vindex,3) points(pindex, 3)], '--b');
    plot3(points(vindex, 1), points(vindex,2), points(vindex,3), 'or', ...
    'markerfacecolor', 'r', 'markersize', 5)
end
hold off
end

