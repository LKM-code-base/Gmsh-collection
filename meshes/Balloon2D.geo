// mesh of a balloon in 3D (semi-circular annulus)

// constants
ri = 0.9;
ro = 1.0;
cl = 0.05;

// Points
Point(1) = {0, 0, 0, cl}; // center of sphere

Point(2) = {0, ri, 0, cl}; // points of inner sphere
Point(3) = {ri, 0, 0, cl};
Point(5) = {-ri, 0, 0, cl};

Point(7) = {0, ro, 0, cl}; // points of outer sphere
Point(8) = {ro, 0, 0, cl};
Point(10) = {-ro, 0, 0, cl};

// Lines

// lines connecting both spheres
Line(11) = {3, 8}; 
Line(12) = {5,10};

// lines of inner sphere
Circle(13) = {2, 1, 3}; 
Circle(14) = {5, 1, 2};

// lines of outer sphere
Circle(15) = {7, 1, 8}; 
Circle(16) = {10, 1, 7};

// Surfaces

// surfaces connecting both spheres
Curve Loop(17) = {16, 15, -11, -13, -14, 12};
Plane Surface(18) = {17};

// Physical regions
Physical Line("inner surface", 1) = {1, 4};
Physical Line("outer surface", 2) = {9, 12};
Physical Line("cutting plane y", 3) = {12, 54};

