function dX = computeDX(edge, theta)
    edge = edge./norm(edge,2);
    u = edge(1); v = edge(2); w = edge(3);
    dX = [-(1-u^2)*sin(theta)           u*v*sin(theta) - w*cos(theta)   u*w*sin(theta)+v*cos(theta);
          u*v*sin(theta) + w*cos(theta)  -(1-v*v)*sin(theta)          v*w*sin(theta) - u*cos(theta);
          u*w*sin(theta) - v*cos(theta)  v*w*sin(theta) + u*cos(theta)   -(1-w*w)*sin(theta)];
end

