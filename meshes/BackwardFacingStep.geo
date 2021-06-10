// mesh of channel with a backward facing step

// geometry parameters
l = 6.0;
h = 1.0;
a = 1.0;

// characteristic size
cl__max = h / 10.0;
cl__med = h / 15.0;
cl__min = h / 25.0;

// points
Point(1) = {0, 0.5 * h, 0, cl__max};
Point(2) = {a, 0.5 * h, 0, cl__max};    // corner point
Point(3) = {a, 0.0, 0, cl__max};        // corner point
Point(4) = {l, 0.0, 0, cl__max};
Point(5) = {l, h, 0, cl__max}; 
Point(6) = {0, h, 0, cl__max};

// lines
Line(1) = {6, 1};
Line(2) = {1, 2};
Line(3) = {2, 3};
Line(4) = {3, 4};
Line(5) = {4, 5};
Line(6) = {5, 6};

// line loop and surfaces
Line Loop(10) = {1, 2, 3, 4, 5, 6};
Plane Surface(10) = {10};

// physical regions
Physical Curve("inlet",100) = {1};
Physical Curve("outlet",101) = {5};
Physical Curve("walls",102) = {2, 3, 4, 6};
Physical Surface("fluid volume",200) = {10};

// definition of size fields
// box behind the step
Field[1] = Box;
Field[1].VIn = cl__max;
Field[1].VOut = 10.0 * cl__max;
Field[1].XMin = 0.5 * l;
Field[1].XMax = l;
Field[1].YMin = 0;
Field[1].YMax = h;
// box in front of the step
Field[2] = Box;
Field[2].VIn = cl__max;
Field[2].VOut = 10.0 * cl__max;
Field[2].XMin = 0.0;
Field[2].XMax = 0.5 * a;
Field[2].YMin = 0.0;
Field[2].YMax = h;
// box close to the step
Field[3] = Box;
Field[3].VIn = cl__med;
Field[3].VOut = 10.0 * cl__max;
Field[3].XMin = 0.5 * a;
Field[3].XMax = 0.5 * l;
Field[3].YMin = 0.0;
Field[3].YMax = h;
// refinement of the walls
Field[4] = Distance;
Field[4].EdgesList = {2, 3, 4, 6};
Field[4].NNodesByEdge = 100;
Field[4].NodesList = {2,3};
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

