// mesh of a plate embedded in free space
// geometry parameters
l = 6.0;
h = 2.0;
a = 5.0;

// characteristic size
cl__max = h / 8.0;
cl__med = h / 12.0;
cl__min = h / 24.0;

// points
Point(1) = {0, 0, 0, cl__max};
Point(2) = {l, 0, 0, cl__max};    
Point(3) = {l, 0.5 * h, 0, cl__max};
Point(4) = {l - a, 0.5 * h, 0, cl__max};    // tip of the plate
Point(5) = {0, 0.5 * h, 0, cl__max}; 
Point(6) = {0, h, 0, cl__max};
Point(7) = {l, h, 0, cl__max};

// lines
Line(1) = {5, 1};
Line(2) = {1, 2};
Line(3) = {2, 3};
Line(4) = {3, 4};
Line(5) = {4, 5};
Line(6) = {6, 5};
Line(7) = {3, 7};
Line(8) = {7, 6};

// line loop and surfaces
Line Loop(10) = {1, 2, 3, 4, 5};
Plane Surface(10) = {10};
Line Loop(11) = {6, -5, -4, 7, 8};
Plane Surface(11) = {11};

// physical regions
Physical Curve("inlet",100) = {1, 6};
Physical Curve("outlet",101) = {3, 7};
Physical Curve("plate",102) = {4};
Physical Curve("top",103) = {2};
Physical Curve("bottom",104) = {8};
Physical Surface("fluid volume",200) = {10, 11};

// definition of size fields
// box parallel the plate
Field[1] = Box;
Field[1].VIn = cl__med;
Field[1].VOut = cl__max;
Field[1].XMin = 0;
Field[1].XMax = l;
Field[1].YMin = 0.2 * h;
Field[1].YMax = 0.8 * h;
// refinement of the tip of the plate
Field[2] = Box;
Field[2].VIn = cl__min;
Field[2].VOut = cl__max;
Field[2].XMin = 0.9 * (l - a);
Field[2].XMax = 1.1 * (l - a);
Field[2].YMin = 0.4 * h;
Field[2].YMax = 0.6 * h;
// refinement of the plate
Field[3] = Distance;
Field[3].EdgesList = {4};
Field[3].NNodesByEdge = 50;
Field[4] = Threshold;
Field[4].IField = 3;
Field[4].DistMax = 4.0 * cl__min;
Field[4].DistMin = 2.0 * cl__min;
Field[4].LcMax = cl__max;
Field[4].LcMin = cl__min;
// background field: minimum of the fields 1, 2, 5
Field[5] = Min;
Field[5].FieldsList = {1, 2, 4};
Background Field = 5;

Mesh.CharacteristicLengthExtendFromBoundary = 0;

