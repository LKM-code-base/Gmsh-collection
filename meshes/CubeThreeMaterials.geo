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
Physical Surface(10) = {volume01[5], volume02[5],   // left surface
                        volume03[5]};
Physical Surface(20) = {volume01[3], volume02[3],   // right surface
                        volume03[3]};
Physical Surface(30) = {plane01[1], plane02[1]};    // bottom surface
Physical Surface(40) = {volume02[0], volume03[0]};  // top surface
Physical Surface(50) = {volume01[2], volume02[2]};  // front surface
Physical Surface(60) = {volume03[4]};               // back surface

// define the material indicators
Physical Volume(0) = volume01[1];
Physical Volume(1) = volume02[1];
Physical Volume(2) = volume03[1];

// make a list of regions
allParts[] = {volume01[1], volume02[1], volume03[1]};

// meshing surfaces by the transfinite algorithm
Transfinite Surface {allParts[]};
