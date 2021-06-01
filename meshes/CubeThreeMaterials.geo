// mesh of a rectangle consisting of two materials

// geometry variables
width = 2.0;
height = 2.0;
depth = 2.0;

// number of points per edge
nx = 6;
ny = 6;
nz = 6;

// point of origin
__lst=newp;
Point(__lst) = {0,0,0};

// extrude point in x-direction
lineX[] = Extrude{width, 0, 0} { Point{__lst}; Layers{nx}; };

// extrude line in y-direction
plane01[] = Extrude{0, height / 2.0, 0} { Line{lineX[1]}; Layers{ny}; };

// extrude line in y-direction
plane02[] = Extrude{0, height / 2.0, 0} { Line{plane01[0]}; Layers{ny}; };

// extrude surface in z-direction
volume01[] = Extrude{0, 0, depth / 2.0} { Surface{plane01[1]}; Layers{nz}; };
volume02[] = Extrude{0, 0, depth / 2.0} { Surface{volume01[0]}; Layers{nz}; };

// extrude surface in z-direction
volume03[] = Extrude{0, 0, depth} { Surface{plane02[1]}; Layers{2*nz}; };

// define the boundary indicators
Physical Surface("left surface", 200) = {volume01[5], volume02[5], volume03[5]};
Physical Surface("right surface", 201) = {volume01[3], volume02[3], volume03[3]};
Physical Surface("bottom surface", 202) = {plane01[1], plane02[1]};
Physical Surface("top surface", 203) = {volume02[0], volume03[0]};
Physical Surface("front surface", 204) = {volume01[2], volume02[2]};
Physical Surface("back surface", 205) = {volume03[4]};

// define the material indicators
Physical Volume("material one", 300) = volume01[1];
Physical Volume("material two", 301) = volume02[1];
Physical Volume("material three", 302) = volume03[1];

