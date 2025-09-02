classdef PermxMeshv1
    properties
        nx
        ny
        nz = 1
        dx
        dy
        dz
        xMin
        xMax
        yMin
        yMax
        zMin
        zMax

        permx            % Matrix of permx values
        initPermx        % Default permx value
        pathPermx        % Value along path
        pathWidth        % Number of cells across (odd preferred)
        xCenters         % X coordinates of cell centers
        yCenters         % Y coordinates of cell centers
        zCenters         % Z coordinates of cell centers
        currentI         % Current row index (y-direction)
        currentJ         % Current column index (x-direction)
    end

    methods
        function obj = PermxMeshv1(nx, ny, xMin, xMax, yMin, yMax, zMin, zMax, initPermx, pathPermx, startPos, pathWidth)
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

            obj.initPermx = initPermx;
            obj.pathPermx = pathPermx;
            obj.pathWidth = pathWidth;

            obj.permx = initPermx * ones(ny, nx); % row = i, col = j
            obj.currentI = startPos(1);
            obj.currentJ = startPos(2);

            % Apply initial path cell
            obj = obj.setPathValue(startPos(1), startPos(2), 'center');

            % Cell centers
            obj.xCenters = xMin + obj.dx/2 : obj.dx : xMax - obj.dx/2;
            obj.yCenters = yMin + obj.dy/2 : obj.dy : yMax - obj.dy/2;
            obj.zCenters = zMin + obj.dz/2 : obj.dz : zMax - obj.dz/2;

        end

        function obj = step(obj, direction, numSteps)
            i = obj.currentI;
            j = obj.currentJ;

            for k = 1:numSteps
                nextI = i;
                nextJ = j;

                switch direction
                    case 'up'
                        nextI = i - 1;
                    case 'down'
                        nextI = i + 1;
                    case 'left'
                        nextJ = j - 1;
                    case 'right'
                        nextJ = j + 1;
                    otherwise
                        error('Invalid direction. Use: up, down, left, right');
                end

                % Stop if next step goes out of bounds
                if nextI < 1 || nextI > obj.ny || nextJ < 1 || nextJ > obj.nx
                    fprintf('Path stopped at edge: (%d, %d) is out of bounds.\n', nextI, nextJ);
                    break;
                end

                % Update position and apply path value
                i = nextI;
                j = nextJ;
                obj = obj.setPathValue(i, j, direction);
            end

            obj.currentI = i;
            obj.currentJ = j;
        end

        function obj = setPathValue(obj, iCenter, jCenter, direction)
            halfWidth = floor(obj.pathWidth / 2);

            switch direction
                case {'up', 'down'}
                    jStart = max(jCenter - halfWidth, 1);
                    jEnd   = min(jCenter + halfWidth, obj.nx);
                    for jj = jStart:jEnd
                        obj.permx(iCenter, jj) = obj.pathPermx;
                    end
                case {'left', 'right'}
                    iStart = max(iCenter - halfWidth, 1);
                    iEnd   = min(iCenter + halfWidth, obj.ny);
                    for ii = iStart:iEnd
                        obj.permx(ii, jCenter) = obj.pathPermx;
                    end
                otherwise
                    % initial point
                    obj.permx(iCenter, jCenter) = obj.pathPermx;
            end
        end

        function saveToFile(obj, folder)
            if ~exist(folder, 'dir')
                mkdir(folder);
            end

            dlmwrite(fullfile(folder, 'xlin.geos'), obj.xCenters', 'delimiter', '\n', 'precision', 6);
            dlmwrite(fullfile(folder, 'ylin.geos'), obj.yCenters', 'delimiter', '\n', 'precision', 6);
            dlmwrite(fullfile(folder, 'zlin.geos'), obj.zCenters', 'delimiter', '\n', 'precision', 6);

            % Flatten permx in GEOS format
            PermxFlat = reshape(permute(obj.permx, [2 1]), [], 1);
            PermxFull = repmat(PermxFlat, obj.nz, 1);
            dlmwrite(fullfile(folder, 'permx.geos'), PermxFull, 'delimiter', '\n', 'precision', 6);
            dlmwrite(fullfile(folder, 'permy.geos'), PermxFull, 'delimiter', '\n', 'precision', 6);
            dlmwrite(fullfile(folder, 'permz.geos'), PermxFull, 'delimiter', '\n', 'precision', 6);
        end
    end
end
