// mesh of rectangle with an inlet and outlet

// geometry parameters
l = 3.0;
h = 1.0;
a = 5.0;

// characteristic size
cl__max = h / 5.0;
cl__med = h / 8.0;
cl__min = h / 10.0;

// points
Point(1) = {0, 0, 0, cl__max};
Point(2) = {l, 0, 0, cl__max};
Point(3) = {l, h, 0, cl__max};           // corner point
Point(4) = {0, h, 0, cl__max};
Point(5) = {l, 2.0 * h + a, 0, cl__max}; // corner point
Point(6) = {l + a, 2.0 * h + a, 0, cl__max};
Point(7) = {2.0 * l + a, 2.0 * h + a, 0, cl__max};
Point(8) = {2.0 * l + a, h + a, 0,cl__max};
Point(9) = {l + a, h + a, 0, cl__max};   // corner point
Point(10) = {l + a, 0, 0, cl__max};      // corner point

// lines
Line(1) = {4, 1};
Line(2) = {1, 2};
Line(3) = {2, 10};
Line(4) = {10, 9};
Line(5) = {9, 8};
Line(6) = {7, 8};
Line(7) = {7, 6};
Line(8) = {6, 5};
Line(9) = {5, 3};
Line(10) = {3, 4};

// line loop and surfaces
Line Loop(12) = {8, 9, 10, 1, 2, 3, 4, 5, -6, 7};
Plane Surface(12) = {12};

// physical regions
Physical Curve("inlet",100) = {1};
Physical Curve("outlet",101) = {6};
Physical Curve("walls",102) = {2, 3, 4, 5, 7, 8, 9, 10};
Physical Surface("fluid volume",200) = {12};

// definition of size fields
// box in rectangular section
Field[1] = Box;
Field[1].VIn = cl__max;
Field[1].VOut = 10.0 * cl__max;
Field[1].XMin = l;
Field[1].XMax = l + a;
Field[1].YMin = h;
Field[1].YMax = h + a;
// box in bottom channel
Field[2] = Box;
Field[2].VIn = cl__med;
Field[2].VOut = 10.0 * cl__max;
Field[2].XMin = 0.0;
Field[2].XMax = a + l;
Field[2].YMin = 0.0;
Field[2].YMax = h;
// box in top channel
Field[3] = Box;
Field[3].VIn = cl__med;
Field[3].VOut = 10.0 * cl__max;
Field[3].XMin = l;
Field[3].XMax = 2.0 * l + a;
Field[3].YMin = a + h;
Field[3].YMax = a + 2.0 * h;
// refinement of the walls
Field[4] = Distance;
Field[4].EdgesList = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
Field[4].NNodesByEdge = 100;
Field[4].NodesList = {3, 5, 9, 10};
Field[5] = Threshold;
Field[5].IField = 4;
Field[5].DistMax = 4.0 * cl__min;
Field[5].DistMin = 2.0 * cl__min;
Field[5].LcMax = cl__max;
Field[5].LcMin = cl__min;
// background field: minimum of the fields 1, 2, 5
Field[6] = Min;
Field[6].FieldsList = {1, 2, 3, 5};
Background Field = 6;

Mesh.CharacteristicLengthExtendFromBoundary = 0;

