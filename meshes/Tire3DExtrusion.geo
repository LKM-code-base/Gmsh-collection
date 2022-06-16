// mesh of a tire crossection in 3D
SetFactory("OpenCASCADE");

// load STEP file
v() = ShapeFromFile("Tire3DExtrusion.stp");

// physical regions
Physical Surface("outer surface", 500) = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                                          11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                          21, 22, 23, 24, 25, 30,
                                          31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
                                          41, 42, 43, 44, 45};
Physical Surface("inner surface", 501) = {27, 28};
Physical Surface("front plane z", 502) = {46};
Physical Surface("back plane z", 503) = {47};
Physical Surface("fixed surface", 504) = {26, 29};
Physical Volume("material", 600) = {1};

// specify a global mesh size
Mesh.MeshSizeMin = 0.05;
Mesh.MeshSizeMax = 0.05;

