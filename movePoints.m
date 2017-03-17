function points = movePoints(points, creases, faces, theta)
    old_points = points;
    for i = 1 : length(faces) % for crease(i)/face(i)
        %compute rotation matrix for crease(i)
        R = eye(3);
        for j = 1 : i
            X = computeX(creases(j,:), theta(j));
            R = R * X;
        end
        %apply rotation to all points in face(i)
        for j = 1 : length(faces{i}) %
            pindex = faces{i}{j};
            points(pindex,:) = (R * old_points(pindex,:)')';
        end
    end
end

