// mesh of a rectangle consisting of two materials

// geometry variables
width = 3.0;
height = 2.0;

// number of points per edge
nx = 6;
ny = 4;

// point of origin
__lst=newp;
Point(__lst) = {0,0,0};

// extrude point in x-direction
lineX[] = Extrude{width, 0, 0} { Point{__lst}; Layers{nx}; };

// extrude line in y-direction
plane01[] = Extrude{0, height / 2.0, 0} { Line{lineX[1]}; Layers{ny}; };

// extrude line in y-direction
plane02[] = Extrude{0, height / 2.0, 0} { Line{plane01[0]}; Layers{ny}; };

// define the boundary indicators
Physical Line(10) = {plane01[3], plane02[3]};
Physical Line(20) = {lineX[1]};
Physical Line(30) = {plane01[2], plane02[2]};
Physical Line(40) = {plane02[0]};

// define the material indicators
Physical Surface(0) = plane01[1];
Physical Surface(1) = plane02[1];

// make a list of regions
allParts[] = {plane01[1], plane02[1]};

// meshing surfaces by the transfinite algorithm
Transfinite Surface {allParts[]};

// use quadriteral elements
Recombine Surface {allParts[]};
