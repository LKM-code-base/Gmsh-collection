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
Physical Line("left", 10) = {plane01[3], plane02[3]};
Physical Line("bottom", 20) = {lineX[1]};
Physical Line("right", 30) = {plane01[2], plane02[2]};
Physical Line("top", 40) = {plane02[0]};

// define the material indicators
Physical Surface("hard material", 1) = plane01[1];
Physical Surface("soft material", 2) = plane02[1];

