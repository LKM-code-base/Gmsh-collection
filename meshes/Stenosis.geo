// axisymmetric mesh of a stenosis

// geometry parameters
xs = 2.0; // position of the stenosis
s = 0.1;  // scaling factor controling the thickness
w = 2.0;  // width of the stenosis
r = 1.0;  // radius of the channel
l = 10.0; // length of the channel

// characteristic length
cl__max = r / 3.0;
cl__med = r / 10.0;
cl__min = r / 25.0;

// channel inlet
Point(1) = {0, 0, 0, cl__max};
Point(2) = {0, r, 0, cl__max};

// stenosis
Point(3) = {xs - w / 2.0, r, 0, cl__max};
Point(4) = {xs + w / 2.0, r, 0, cl__max};

// channel outlet
Point(5) = {l, r, 0, cl__max};
Point(6) = {l, 0, 0, cl__max};

// control point of stenosis
Point(7) = {xs - w / 4.0, r, 0, cl__max};
Point(8) = {xs + w / 4.0, r, 0, cl__max};
Point(9) = {xs, s * r, 0, cl__max};

// lines
Line(1) = {1, 2};
Line(2) = {2, 3};
BSpline(3) = {3, 7, 9, 8, 4};
Line(4) = {4, 5};
Line(5) = {5, 6};
Line(6) = {6, 1};

// surface definitions
Line Loop(1) = {1, 2, 3, 4, 5, 6};
Plane Surface(1) = {1};

// physical regions
Physical Curve("wall", 10) = {2, 3, 4};
Physical Curve("outlet", 20) = {5};
Physical Curve("symmetry", 30) = {6};
Physical Curve("inlet", 40) = {1};
Physical Surface("fluid", 100) = {1};


// definition of size fields
// box in front of the stenosis
Field[1] = Box;
Field[1].VIn = cl__med;
Field[1].VOut = cl__max;
Field[1].XMax = xs - w / 2.0;
Field[1].XMin = 0.0;
Field[1].YMin = 0.0;
Field[1].YMax = r;
// box behind the stenosis
Field[2] = Box;
Field[2].VIn = cl__med;
Field[2].VOut = cl__max;
Field[2].XMax = xs + 2.0 * w;
Field[2].XMin = xs + w / 2.0;
Field[2].YMin = 0.0;
Field[2].YMax = r;
// box below the stenosis
Field[3] = Box;
Field[3].VIn = cl__med;
Field[3].VOut = cl__max;
Field[3].XMax = xs + w / 2.0;
Field[3].XMin = xs - w / 2.0;
Field[3].YMin = 0.0;
Field[3].YMax = r;
// refinement of the channel walls
Field[4] = Distance;
Field[4].EdgesList = {2, 3, 4};
Field[4].NNodesByEdge = 200;
Field[5] = Threshold;
Field[5].IField = 4;
Field[5].DistMax = 0.2 * r;
Field[5].DistMin = 0.05 * r;
Field[5].LcMax = cl__max;
Field[5].LcMin = cl__min;
// background field: minimum of the fields 1, 2, 4
Field[6] = Min;
Field[6].FieldsList = {1, 2, 3, 5};
Background Field = 6;
