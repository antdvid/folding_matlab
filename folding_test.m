%folding method
function folding_test(points, edges, creases, faces, rhoT, maxIter, outfile)
%number of crease lines
N = size(creases, 1);
rho = zeros(1, N);
rho_series = zeros(maxIter, N);
creases_vect = points(creases(:, 2), :) - points(creases(:,1), :);
points0 = points;
rho_series(1, :) = rho;

for k = 2 : maxIter
    drho0 = rhoT - rho;
    drho0 = (0.8 * drho0/norm(drho0) + 0.1 * (rand(1,N)*2 -1)) * 0.02;
    X = zeros(3, 3, N);
    dX = X;
    for i = 1 : N
        dX(:,:, i) = computeDX(creases_vect(i,:), rho(i));
        X(:,:, i)  = computeX(creases_vect(i,:), rho(i));
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
    rho = rho + drho';
    rho
    points = movePoints(points0, creases_vect, faces, rhoT);
    rho_series(k,:) = rho;
    cla
    set(gca,'color','none')
    axis off
    draw(points, edges, creases);
    pause(0.1)
    if (norm(drho') < 1e-5)
        fprintf('convergence reached, d_rho = %f\n', norm(drho));
        break;
    end
end
figure(2)
plot(rho_series, 'o-')