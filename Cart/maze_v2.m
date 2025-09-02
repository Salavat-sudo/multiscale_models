clear; clc;
mult = 4;
nx = 20 * mult;
ny = 20 * mult;

xMin = 0; xMax = 10;
yMin = 0; yMax = 10;
zMin = 0; zMax = 1;

initVal = 1;
pathVal = 10000;
startPos = [10, 1]; % (i,j)
pathWidth = 1;

mesh = PermxMeshv1(nx, ny, xMin, xMax, yMin, yMax, zMin, zMax, initVal, pathVal, startPos, pathWidth);
mesh = mesh.step('right',  5);
mesh = mesh.step( 'down', 60);
mesh = mesh.step('right', 10);
mesh = mesh.step(   'up', 60);
mesh = mesh.step('right', 10);
mesh = mesh.step( 'down', 60);
mesh = mesh.step('right', 10);
mesh = mesh.step(   'up', 60);
mesh = mesh.step('right', 10);
mesh = mesh.step( 'down', 60);
mesh = mesh.step('right', 10);
mesh = mesh.step(   'up', 60);
mesh = mesh.step('right', 10);
mesh = mesh.step( 'down', 60);
mesh = mesh.step('right', 10);
mesh = mesh.step(   'up', 60);
mesh = mesh.step('right', 10);
mesh = mesh.step('right', 5*mult);

% Display permx field
imagesc(mesh.permx);
axis equal tight;
colorbar;
title('Permx Field with Path Width');

mesh.saveToFile('heterogenLarge_v3');
