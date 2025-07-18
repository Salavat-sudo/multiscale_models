classdef PermxMesh
    properties
        nx
        ny
        nz = 1
        xMin
        xMax
        yMin
        yMax
        zMin
        zMax

        dx
        dy
        dz

        Xi
        Yi
        Zi

        permx
        pathPermxValue
        lastPos   % [i, j]
        pathWidth
    end

    methods
        function obj = PermxMesh(nx, ny, xMin, xMax, yMin, yMax, zMin, zMax, initPermxValue, pathPermxValue, startPos, pathWidth)
            obj.nx = nx;
            obj.ny = ny;
            obj.nz = 1;

            obj.xMin = xMin;
            obj.xMax = xMax;
            obj.yMin = yMin;
            obj.yMax = yMax;
            obj.zMin = zMin;
            obj.zMax = zMax;

            obj.dx = (xMax - xMin) / nx;
            obj.dy = (yMax - yMin) / ny;
            obj.dz = (zMax - zMin) / obj.nz;

            obj.Xi = xMin + obj.dx/2 : obj.dx : xMax - obj.dx/2;
            obj.Yi = yMin + obj.dy/2 : obj.dy : yMax - obj.dy/2;
            obj.Zi = zMin + obj.dz/2 : obj.dz : zMax - obj.dz/2;

            obj.permx = initPermxValue * ones(nx, ny);
            obj.pathPermxValue = pathPermxValue;
            obj.lastPos = startPos;  % [i, j]
            obj.pathWidth = pathWidth;
        end

        function obj = step(obj, direction, numCells)
            i = obj.lastPos(1);
            j = obj.lastPos(2);

            for k = 1:numCells
                switch lower(direction)
                    case 'up'
                        jNew = j + 1;
                        iNew = i;
                    case 'down'
                        jNew = j - 1;
                        iNew = i;
                    case 'right'
                        iNew = i + 1;
                        jNew = j;
                    case 'left'
                        iNew = i - 1;
                        jNew = j;
                    otherwise
                        error('Unknown direction: %s', direction);
                end

                % Check bounds
                if iNew < 1 || iNew > obj.nx || jNew < 1 || jNew > obj.ny
                    fprintf('Out of bounds reached at (%d, %d). Stopping path.\n', iNew, jNew);
                    return;
                end

                % Apply width
                halfWidth = floor(obj.pathWidth / 2);
                for di = -halfWidth : halfWidth
                    for dj = -halfWidth : halfWidth
                        ii = iNew + di;
                        jj = jNew + dj;
                        if ii >= 1 && ii <= obj.nx && jj >= 1 && jj <= obj.ny
                            obj.permx(ii, jj) = obj.pathPermxValue;
                        end
                    end
                end

                i = iNew;
                j = jNew;
                obj.lastPos = [i, j];
            end
        end

        function saveToFile(obj, folder)
            if ~exist(folder, 'dir')
                mkdir(folder);
            end

            dlmwrite(fullfile(folder, 'xlin.geos'), obj.Xi', 'delimiter', '\n', 'precision', 6);
            dlmwrite(fullfile(folder, 'ylin.geos'), obj.Yi', 'delimiter', '\n', 'precision', 6);
            dlmwrite(fullfile(folder, 'zlin.geos'), obj.Zi', 'delimiter', '\n', 'precision', 6);

            % Flatten permx in GEOS format
            PermxFlat = reshape(permute(obj.permx, [2 1]), [], 1);
            PermxFull = repmat(PermxFlat, obj.nz, 1);
            dlmwrite(fullfile(folder, 'permx.geos'), PermxFull, 'delimiter', '\n', 'precision', 6);
        end
    end
end
