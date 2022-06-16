// mesh of a rectangle consisting of two materials

// geometry variables
width = 1.0;
height = 1.0;
depth = 1.0;

// number of points per edge
nx = 1;
ny = 1;
nz = 1;

// point of origin
__lst=newp;
Point(__lst) = {0,0,0};

// extrude point in x-direction
lineX[] = Extrude{width, 0, 0} { Point{__lst}; Layers{nx}; };

// extrude line in y-direction
plane01[] = Extrude{0, height, 0} { Line{lineX[1]}; Layers{ny}; };

// extrude surface in z-direction
volume01[] = Extrude{0, 0, depth} { Surface{plane01[1]}; Layers{nz}; };

// define the boundary indicators
Physical Surface("bottom surface", 202) = {plane01[1]};
Physical Surface("left surface", 200) = {volume01[5]};
Physical Surface("right surface", 201) = {volume01[3]};
Physical Surface("top surface", 203) = {volume01[0]};
Physical Surface("front surface", 204) = {volume01[2]};
Physical Surface("back surface", 205) = {volume01[4]};

// define the material indicators
Physical Volume("material", 300) = volume01[1];
