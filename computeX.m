function X = computeX(edge, theta)
%compute roatation matrix spin around edge by theta
edge = edge ./ norm(edge, 2);
u = edge(1); v = edge(2); w = edge(3);
X = [u*u + (1-u^2)*cos(theta)           u*v*(1-cos(theta)) - w*sin(theta)   u*w*(1-cos(theta))+v*sin(theta);
     u*v*(1-cos(theta)) + w*sin(theta)  v*v + (1 - v*v)*cos(theta)          v*w*(1-cos(theta)) - u*sin(theta);
     u*w*(1-cos(theta)) - v*sin(theta)  v*w*(1-cos(theta)) + u*sin(theta)   w*w+(1-w*w)*cos(theta)];
end

