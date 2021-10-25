// mesh of a tire segment
SetFactory("OpenCASCADE");

// load STEP file
v() = ShapeFromFile("TireSegment.stp");

// physical regions
Physical Surface("inner surface", 10) = {7};
Physical Surface("outer surface", 20) = {1, 2, 3, 4, 5, 8, 9, 10, 11, 12, 13,
                                         14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24};
Physical Surface("cutting plane x", 30) = {6};
Physical Surface("cutting plane y", 40) = {25};
Physical Surface("cutting plane z", 50) = {26};


// specify a global mesh size
Mesh.MeshSizeMin = 0.05;
Mesh.MeshSizeMax = 0.05;
