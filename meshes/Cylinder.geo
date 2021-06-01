// mesh of a cylinder

// geometry parameters
h = 3.0; // height
r = 1.0; // radius

// characteristic length
cl_max = 0.5;
cl_med = cl_max / 2.0;
cl_min = cl_max / 5.0;

// points
Point(1) = {0, 0, 0, cl_max};
Point(2) = {r, 0, 0, cl_max};
Point(3) = {0, 0, h, cl_max};
Point(4) = {r, 0, h, cl_max};

// lines
Line(1) = {1, 2};
Line(2) = {2, 4};
Line(3) = {4, 3};
Line(4) = {3, 1};
Line Loop(5) = {1,2,3,4};
Plane Surface(6) = {5};


// extrusion
/*

After executing the command

   sec[] = Extrude {{0, 0, 1}, {0, 0, 0}, Pi/2} { Surface{6}; };

the array ``sec`` contains object identifiers in the following order:
    [0]	- front surface (opposed to source surface)
    [1] - extruded volume
    [2] - bottom surface (belonging to 1st line in "Line Loop (6)")
    [3] - right surface (belonging to 2nd line in "Line Loop (6)")
    [4] - top surface (belonging to 3rd line in "Line Loop (6)")
    [5] - left surface (belonging to 4th line in "Line Loop (6)") 

*/
// first section
secA[] = Extrude {{0, 0, 1}, {0, 0, 0}, Pi/2} { Surface{6}; };
// second section
secB[] = Extrude {{0, 0, 1}, {0, 0, 0}, Pi/2} { Surface{secA[0] };
};
// third section
secC[] = Extrude {{0, 0, 1}, {0, 0, 0}, Pi/2} { Surface{secB[0] };
};
// fourth section
secD[] = Extrude {{0, 0, 1}, {0, 0, 0}, Pi/2} { Surface{secC[0] };
};

// physical groups
Physical Surface("bottom surface", 200) = {secA[2], secB[2], secC[2], secD[2]};
Physical Surface("top surface", 201) = {secA[4], secB[4], secC[4], secD[4]};
Physical Surface("outer surface", 202) = {secA[3], secB[3], secC[3], secD[3]};
Physical Volume("whole volume", 300) = {secA[1], secB[1], secC[1], secD[1]};

// size fields
// distance field
Field[1] = Distance;
Field[1].NNodesByEdge = 1000; // number of attractors on the edges
Field[1].EdgesList = {51, 68, 17, 34, 13, 30, 47, 64};
Field[1].NodesList = {22, 4, 10, 16, 6, 12, 18, 2};
// threshold Field
Field[2] = Threshold;
Field[2].DistMax = h / 5.0;
Field[2].DistMin = h / 10.0;
Field[2].LcMax = cl_med;
Field[2].LcMin = cl_min;
Field[2].IField = 1;
Field[2].StopAtDistMax = 1;
// background field
Field[3] = Min;
Field[3].FieldsList = {2};
Background Field = 3;
