// mesh of a rectangle consisting of two materials

// geometry variables
width = 1.0;
height = 1.0;

// number of points per edge
nx = 3;
ny = 1;

// point of origin
__lst=newp;
Point(__lst) = {0,0,0};

// extrude point in x-direction
lineX[] = Extrude{width, 0, 0} { Point{__lst}; Layers{nx}; };

// extrude line in y-direction
plane01[] = Extrude{0, height / 3.0, 0} { Line{lineX[1]}; Layers{ny}; };

// extrude line in y-direction
plane02[] = Extrude{0, height / 3.0, 0} { Line{plane01[0]}; Layers{ny}; };

// extrude line in y-direction
plane03[] = Extrude{0, height / 3.0, 0} { Line{plane02[0]}; Layers{ny}; };


// define the boundary indicators
Physical Line("left", 10) = {plane01[3], plane02[3], plane03[3]};
Physical Line("bottom", 20) = {lineX[1]};
Physical Line("right", 30) = {plane01[2], plane02[2], plane03[2]};
Physical Line("top", 40) = {plane03[0]};

// define the material indicators
Physical Surface("steel", 1) = plane01[1];
Physical Surface("copper", 2) = plane02[1];
Physical Surface("aluminium", 3) = plane03[1];

