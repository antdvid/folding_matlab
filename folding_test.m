%folding method
function rho_series = folding_test(points, edges, creases, faces, rhoT, maxIter, outfile)
%number of crease lines
N = size(creases, 1);
rho = zeros(1, N);
rho_series = zeros(maxIter, N);
creases_vect0 = points(creases(:, 2), :) - points(creases(:,1), :);
points0 = points;
rho_series(1, :) = rho;

for k = 1 : maxIter
    creases_vect = points(creases(:, 2), :) - points(creases(:,1), :);
    drho0 = rhoT - rho;
    drho0 = drho0/norm(drho0) * 0.001;
    X = zeros(3, 3, N);
    dX = X;
    for i = 1 : N
        dX(:,:, i) = computeDX(creases_vect(i,:), drho0(i));
        X(:,:, i)  = computeX(creases_vect(i,:), drho0(i));
    end
    drho0 = drho0 * 50;
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
    rho = rho + drho';
    points = movePoints(points0, creases_vect0, faces, rho);
    rho_series(k,:) = rho;
    cla
    set(gcf,'color','white')
    axis off
    draw(points, edges, creases);
    save_movie(k, outfile)
    pause(0.01)
    if (norm(drho0') < 1e-5)
        fprintf('convergence reached, d_rho = %f\n', norm(drho0));
        break;
    end
end
