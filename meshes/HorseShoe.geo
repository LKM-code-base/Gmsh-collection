// mesh of a horseshoe magnet
Geometry.ExtrudeReturnLateralEntities = 0;

// geometric parameters
Rm = 1.;                 // mean radius
h = 20. / 21. * Rm;      // height
d = 2. / 10. * Rm;       // depth
w = 3. / 10. * Rm;       // width
alpha = 90. / 180. * Pi; // angle
k = 3.;                  // scaling factor
ell =  k * Rm;           

// characteristic sizes
magLen = 1.0 / 8.0;
farLen = 1.0 / 2.0;

// points of the horseshoe
// circular segment
upCenter = newp; Point(upCenter) = {0, 0, d, magLen};
upInnerArcMiddle = newp; Point(upInnerArcMiddle) = {Rm - w, 0., d, magLen};
upOuterArcMiddle = newp; Point(upOuterArcMiddle) = {Rm + w, 0., d, magLen};
upInnerArcLow = newp; Point(upInnerArcLow) = {Cos(-alpha) * (Rm - w), Sin(-alpha) * (Rm - w), d, magLen};
upInnerArcHigh = newp; Point(upInnerArcHigh) = {Cos(alpha) * (Rm - w), Sin(alpha) * (Rm - w), d, magLen};
upOuterArcLow = newp; Point(upOuterArcLow) = {Cos(-alpha) * (Rm + w), Sin(-alpha) * (Rm + w), d, magLen};
upOuterArcHigh = newp; Point(upOuterArcHigh) = {Cos(alpha) * (Rm + w), Sin(alpha) * (Rm + w), d, magLen};
// first upper rectangle
upFirstInner = newp; Point(upFirstInner) = {Cos(alpha) * (Rm - w) - Sin(alpha) * 2 * h, Sin(alpha) * (Rm - w) + Cos(alpha) * 2 * h, d, magLen};
upFirstOuter = newp; Point(upFirstOuter) = {Cos(alpha) * (Rm + w) - Sin(alpha) * 2 * h, Sin(alpha) * (Rm + w) + Cos(alpha) * 2 * h, d, magLen};
// second upper rectangle
upSecondInner = newp; Point(upSecondInner) = {Cos(-alpha) * (Rm - w) + Sin(-alpha) * 2 * h, Sin(-alpha) * (Rm - w) - Cos(-alpha) * 2 * h, d, magLen};
upSecondOuter = newp; Point(upSecondOuter) = {Cos(-alpha) * (Rm + w) + Sin(-alpha) * 2 * h, Sin(-alpha) * (Rm + w) - Cos(-alpha) * 2 * h, d, magLen};

// lines of the horseshoe
// circular segment
upCircleInnerSecond = newreg; Circle(upCircleInnerSecond) = {upInnerArcLow, upCenter, upInnerArcMiddle};
upCircleInnerFirst = newreg; Circle(upCircleInnerFirst) = {upInnerArcMiddle, upCenter, upInnerArcHigh};
upCircleOuterHigh = newreg; Circle(upCircleOuterHigh) = {upOuterArcHigh, upCenter, upOuterArcMiddle};
upCircleOuterLow = newreg; Circle(upCircleOuterLow) = {upOuterArcMiddle, upCenter, upOuterArcLow};
// first upper rectangle
upFirstLineInner = newreg; Line(upFirstLineInner) = {upInnerArcHigh, upFirstInner};
upFirstLineEnd = newreg; Line(upFirstLineEnd) = {upFirstInner, upFirstOuter};
upFirstLineOuter = newreg; Line(upFirstLineOuter) = {upFirstOuter, upOuterArcHigh};
// second upper rectangle
upSecondLineInner = newreg; Line(upSecondLineInner) = {upOuterArcLow, upSecondOuter};
upSecondLineEnd = newreg; Line(upSecondLineEnd) = {upSecondOuter, upSecondInner};
upSecondLineOuter = newreg; Line(upSecondLineOuter) = {upSecondInner, upInnerArcLow};

// line loops for 
upContour = newreg; 
Line Loop(upContour) = {upCircleInnerFirst, upFirstLineInner, 
												upFirstLineEnd, upFirstLineOuter,
												upCircleOuterHigh, upCircleOuterLow,
												upSecondLineInner, upSecondLineEnd,
												upSecondLineOuter, upCircleInnerSecond};

// surfaces
MagSurf = {};
upMagSurf = newreg; Plane Surface(upMagSurf) = {upContour};
MagSurf[0] = upMagSurf;
lowMagSurf[] = Translate {0., 0., -2 * d} {Duplicata{Surface{upMagSurf};}};
MagSurf[1] = lowMagSurf[0];

dump[] = Extrude {0., 0., -2 * d} { Line{
							upCircleInnerFirst, upFirstLineInner,
							upFirstLineEnd, upFirstLineOuter,
							upCircleOuterHigh, upCircleOuterLow,
							upSecondLineInner, upSecondLineEnd,
							upSecondLineOuter, upCircleInnerSecond }; };

row = 2;
For t In {1:20:2}
	MagSurf[row] = dump[t];
	row = row + 1;
EndFor

// order the surfaces
dump = MagSurf[0];
MagSurf[0] = MagSurf[1];
MagSurf[1] = MagSurf[2];
MagSurf[2] = dump;

// volumes
magnetSurface = newreg; Surface Loop(magnetSurface) = MagSurf[];
magnetVolume = newreg; Volume(magnetVolume) = {magnetSurface};

// physical regions
Physical Surface("whole surface", 200) = MagSurf[];
Physical Volume("whole volume", 300) = magnetVolume;

