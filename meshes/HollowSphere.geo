// Ids of the physical regions
int_face_id = 100;
ext_face_id = 101;
shell_vol_id = 100;

// characteristic length
int_len = 0.125;
ext_len = 0.25;

// dimensions (unit length)
r = 0.5;
R = 1.0;

// function constructing sphere of radius rho
c[] = {0.0, 0.0, 0.0};
rho = 1.0;
cl = 0.1;
Macro ConstructSphereSurface
    // construction points
    center = newp;  Point(center) = {c[0], c[1], c[2], cl};
    east = newp;    Point(east) = {c[0] + rho, c[1], c[2], cl};
    west = newp;    Point(west) = {c[0] - rho, c[1], c[2], cl};
    north = newp;   Point(north) = {c[0], c[1] + rho , c[2], cl};
    south = newp;   Point(south) = {c[0], c[1] -rho, c[2], cl};
    top = newp;     Point(top) = {c[0], c[1], c[2] + rho, cl};
    bottom = newp;  Point(bottom) = {c[0], c[1], c[2] - rho, cl};

    // circles
    circleList01 = {};
    tmp = newreg; Circle(tmp) = {top, center, east}; circleList01[0] = tmp;
    tmp = newreg; Circle(tmp) = {east, center, bottom}; circleList01[1] = tmp;
    tmp = newreg; Circle(tmp) = {bottom, center, west}; circleList01[2] = tmp;
    tmp = newreg; Circle(tmp) = {west, center, top}; circleList01[3] = tmp;
    circleList02 = {};
    tmp = newreg; Circle(tmp) = {north, center, east}; circleList02[0] = tmp;
    tmp = newreg; Circle(tmp) = {east, center, south}; circleList02[1] = tmp;
    tmp = newreg; Circle(tmp) = {south, center, west}; circleList02[2] = tmp;
    tmp = newreg; Circle(tmp) = {west, center, north}; circleList02[3] = tmp;

    // surfaces
    tmp = newreg; Line Loop(tmp) = {circleList02[3], circleList02[0], -circleList01[0], -circleList01[3]};
    upNorth = newreg; Ruled Surface(upNorth) = {tmp};
    tmp = newreg; Line Loop(tmp) = {circleList02[1], circleList02[2], circleList01[3], circleList01[0]};
    upSouth = newreg; Ruled Surface(upSouth) = {tmp};
    tmp = newreg; Line Loop(tmp) = {circleList02[3], circleList02[0], circleList01[1], circleList01[2]};
    botNorth = newreg; Ruled Surface(botNorth) = {tmp};
    tmp = newreg; Line Loop(tmp) = {circleList02[1], circleList02[2], -circleList01[2], -circleList01[1]};
    botSouth = newreg; Ruled Surface(botSouth) = {tmp};

    // outer volume
    surfaceLoop = newreg; Surface Loop(surfaceLoop) = {upNorth, upSouth, botNorth, botSouth};
    surfaceList[] = {upNorth, upSouth, botNorth, botSouth};
Return

// inner volume
rho = r; cl = int_len;
Call ConstructSphereSurface;
innerSurfLoop = surfaceLoop;
Physical Surface(int_face_id) = surfaceList[];

// shell volume
rho = R; cl = ext_len;
Call ConstructSphereSurface;
shellSurfLoop = surfaceLoop;
Physical Surface(ext_face_id) = surfaceList[];
shellVolume = newreg; Volume(shellVolume) = {shellSurfLoop, innerSurfLoop};
Physical Volume(shell_vol_id) = shellVolume;
