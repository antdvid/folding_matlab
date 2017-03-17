%folding method
function folding(points, edges, creases, faces, rhoT, maxIter, outfile)
%number of crease lines
draw(points, edges, creases);
N = size(creases, 1);
rho = zeros(1, N);
w = 0.05;
rho_series = zeros(maxIter, N);
for k = 1 : maxIter
    creases_vect = points(creases(:, 2), :) - points(creases(:,1), :);
    drho0 = (rhoT - rho);
    drho0 = drho0/norm(drho0) * w;
    X = zeros(3, 3, N);
    dX = X;
    for i = 1 : N
        dX(:,:, i) = computeDX(creases_vect(i,:), drho0(i));
        X(:,:, i)  = computeX(creases_vect(i,:), drho0(i));
    end

    F = eye(3);
    for i = 1 : N
        F = F * X(:,:, i);
    end
    C = zeros(3, N);
    for i = 1 : N
        dFi = eye(3);
        for j = 1 : N
            if (j == i)
                dFi = dFi * dX(:,:,i);
            else
                dFi = dFi * X(:,:,i);
            end
        end
        C(:, i) = [-dFi(1,2) -dFi(2,3) dFi(1,3)]';
    end
    if (rank(C*C') < min(size(C*C')))
        C_p = pinv(C);
    else
        C_p = C' * (C*C')^(-1);
    end
    drho = (eye(N) - C_p * C) * drho0';
    points = movePoints(points, creases_vect, faces, drho);
    rho_series(k,:) = rho;
    rho = rho + drho';
    xlim([-2 2])
    ylim([-2 2])
    zlim([-2 2])
    cla
    set(gca,'color','none')
    axis off
    draw(points, edges, creases);
    %save movie
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k==1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
    
    if (norm(drho') < 1e-5)
        fprintf('convergence reached, d_rho = %f\n', norm(drho));
        break;
    end
end
figure(2)
plot(rho_series)