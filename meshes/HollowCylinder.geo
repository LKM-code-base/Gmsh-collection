// geometry variables
inner_radius = 0.35;
outer_radius = 1.0;
height = 0.25;

// mesh density variables
nr = 10;
nz = 10;
nphi = 32;

// starting point
__lst=newp;
Point(__lst) = {inner_radius,0,0};

// extrude point in x-direction
lineX[] = Extrude{outer_radius-inner_radius, 0, 0} { Point{__lst}; Layers{nr}; };

// extrude line in z-direction
plane00[] = Extrude{0, 0, height} { Line{lineX[1]}; Layers{nz}; };

// revolute surfaces in phi-direction
plane01[] = Extrude{{0, 0, 1}, {0, 0 ,0}, Pi/2}{ Surface{plane00[1]}; Layers{nphi}; };
plane02[] = Extrude{{0, 0, 1}, {0, 0 ,0}, Pi/2}{ Surface{plane01[0]}; Layers{nphi}; };
plane03[] = Extrude{{0, 0, 1}, {0, 0 ,0}, Pi/2}{ Surface{plane02[0]}; Layers{nphi}; };
plane04[] = Extrude{{0, 0, 1}, {0, 0 ,0}, Pi/2}{ Surface{plane03[0]}; Layers{nphi}; Recombine; };

// boundary indicators
top_surface = 100;
bottom_surface = 101;
inner_surface = 102;
outer_surface = 103;

// group surfaces and assign an indicator
Physical Surface(top_surface) = {plane01[4], plane02[4], plane03[4], plane04[4]};
Physical Surface(bottom_surface) = {plane01[2], plane02[2], plane03[2], plane04[2]};
Physical Surface(inner_surface) = {plane01[5], plane02[5], plane03[5], plane04[5]};
Physical Surface(outer_surface) = {plane01[3], plane02[3], plane03[3], plane04[3]};
