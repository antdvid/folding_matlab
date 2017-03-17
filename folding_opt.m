%folding method
function rho_series = folding_opt(points, edges, creases, faces, rhoT, maxIter, outfile)
%number of crease lines
N = size(creases, 1);

w0 = 0.8;
w1 = 0.2;
w2 = 0.01;
w = w0;
D = 0.015;
rho_series = zeros(maxIter, N);
rho_delta = zeros(1,N);
points0 = points;
creases_vect = points(creases(:, 2), :) - points(creases(:,1), :);
for k = 1 : maxIter
    if (norm(rho_delta - rhoT) < 1e-2)
        display('convergence reached: err = 1e-2');
        break;
    end
    rho_rand = (rand(1,N)*2 -1) * pi;
    %rho_rand = rand(1,N)*pi;
    rho_rand(rhoT < 0) = rho_rand(rhoT < 0) * -1;
    dir = (1 - w)*rho_rand + w * rhoT;
    %dir = dir / norm(dir);
    rho_tau = rho_delta + D * dir;
    rho = findFoldable(rho_tau, points0, creases);
    if (isValid(rho) && norm(rhoT - rho) < norm(rhoT - rho_delta))
        rho_delta = rho;
        w = w + w1;
        rho_series(k,:) = rho';
        points = movePoints(points0, creases_vect, faces, rho);
        cla
        set(gcf,'color','white')
        axis off
        draw(points, edges, creases)
        save_movie(k, outfile)
        pause(0.001)
    else
        w = w - w2;
    end
    w = max(min([w 1]), 0);
end
points = movePoints(points0, creases_vect, faces, rho);
draw(points, edges, creases)
end

function res = isValid(rho, points, creases)
    if (sum(abs(rho) > pi) == 0)
        res = true;
    else
        res = false;
    end
end

function rho = findFoldable(rho_tau, points, creases)
    opt = optimset('TolFun', 1e-3);
    rho = fminsearch(@(rho)target_function(rho, points, creases), rho_tau, opt);
end

function F = target_function(rho, points, creases)
    vertices = unique(creases(:,1));
    F = 0;
    for i = 1 : length(vertices)
        X = eye(3);
        for j = 1 : size(creases,1)
            if (creases(j,1) == vertices(i))
                creases_vect = points(creases(j,2), :) ...
                            - points(creases(j,1), :);
                X = X * computeX(creases_vect, rho(j));
            end
        end
        F = F + norm(X - eye(3),1);
    end
end

function X = computeF(rho, points, creases)
    vertices = unique(creases(:, 1));
    for i = 1 : length(vertices)
        X = eye(3);
        for j = 1 : size(creases, 1)
            if (creases(j,1) == vertices(i))
                creases_vect = points(creases(j,2), :) - ...
                                points(creases(j,1), :);
                X = X * computeX(creases_vect, rho(j));
            end
        end
    end
end