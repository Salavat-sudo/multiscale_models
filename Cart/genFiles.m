clear, clc

xMin =  0;
xMax = 10;
yMin =  0;
yMax = 10;
zMin =  0;
zMax =  1;

PermxAv = 0.2;

nx = 10;
ny = 10;
nz = 1;

dx = (xMax - xMin)./(nx);
dy = (yMax - yMin)./(ny);
dz = (zMax - zMin)./(nz);

Xi = xMin+dx/2: dx: xMax-dx/2
Yi = yMin+dy/2: dy: yMax-dy/2
Zi = zMin+dz/2: dz: zMax-dz/2

dlmwrite('heterogen/xlin.geos', Xi, 'delimiter', '\n', 'precision', 6);
dlmwrite('heterogen/ylin.geos', Yi, 'delimiter', '\n', 'precision', 6);
dlmwrite('heterogen/zlin.geos', Zi, 'delimiter', '\n', 'precision', 6);

Permx = PermxAv * rand(nx*ny*nz);
dlmwrite('heterogen/permx.geos', Permx, 'delimiter', '\n', 'precision', 6);
