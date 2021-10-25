// mesh of a balloon in 3D (semi-spherically annulus)

// constants
ri = 0.9;
ro = 1.0;
cl = 0.1;

// Points

// center of sphere
Point(1) = {0, 0, 0, cl}; 

// points of inner sphere
Point(2) = {0, ri, 0, cl}; 
Point(3) = {ri, 0, 0, cl};
Point(4) = {0, -ri, 0, cl};
Point(5) = {-ri, 0, 0, cl};
Point(6) = {0, 0, ri, cl};

// points of outer sphere
Point(7) = {0, ro, 0, cl};
Point(8) = {ro, 0, 0, cl};
Point(9) = {0, -ro, 0, cl};
Point(10) = {-ro, 0, 0, cl};
Point(11) = {0, 0, ro, cl};

// Lines

// lines connecting both spheres
Line(51) = {2, 7}; 
Line(52) = {3, 8};
Line(53) = {4, 9};
Line(54) = {5,10};
Line(55) = {6,11};

// lines of inner sphere
Circle(1) = {2, 1, 3}; 
Circle(2) = {3, 1, 4};
Circle(3) = {4, 1, 5};
Circle(4) = {5, 1, 2};
Circle(5) = {2, 1, 6};
Circle(6) = {3, 1, 6};
Circle(7) = {4, 1, 6};
Circle(8) = {5, 1, 6};

// lines of outer sphere
Circle(9) = {7, 1, 8}; 
Circle(10) = {8, 1, 9};
Circle(11) = {9, 1, 10};
Circle(12) = {10, 1, 7};
Circle(13) = {7, 1, 11};
Circle(14) = {8, 1, 11};
Circle(15) = {9, 1, 11};
Circle(16) = {10, 1, 11};

// Surfaces

// surfaces connecting both spheres
Line Loop(51) = {51, 9, -52, -1}; 
Plane Surface(51) = {51};
Line Loop(52) = {52, 10, -53, -2};
Plane Surface(52) = {52};
Line Loop(53) = {53, 11, -54, -3};
Plane Surface(53) = {53};
Line Loop(54) = {54, 12, -51, -4};
Plane Surface(54) = {54};

Surface Loop(100) = {51, 52, 53, 54};

// surfaces of inner sphere
Line Loop(2) = {1, 6, -5}; 
Surface(2) = {2};
Line Loop(3) = {2, 7, -6};
Surface(3) = {3};
Line Loop(4) = {3, 8, -7};
Surface(4) = {4};
Line Loop(5) = {4, 5, -8};
Surface(5) = {5};

Surface Loop(200) = {2, 3, 4, 5};

// surfaces of outer sphere
Line Loop(6) = {9, 14, -13}; 
Surface(6) = {6};
Line Loop(7) = {10, 15, -14};
Surface(7) = {7};
Line Loop(8) = {11, 16, -15};
Surface(8) = {8};
Line Loop(9) = {12, 13, -16};
Surface(9) = {9};

Surface Loop(300) = {6, 7, 8, 9};

// Volumes
Volume(1) = {100, 200, 300};

// Physical regions
Physical Volume("volume", 0) = {1};
Physical Surface("inner sphere", 1) = {2, 3, 4, 5};
Physical Surface("outer sphere", 2) = {6, 7, 8, 9};
Physical Surface("cutting plane z", 3) = {51, 52, 53, 54};
