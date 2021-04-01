
include <simpleModules.scad>;
//include <bend.scad>;

//unit conversion
//1 inch = 2.54 cm
//1 cm = 0.3937 inch

//crown is a rectangle with 4 diagonal squares
//baby doll = 6.5in
bandCircumference=16.51;
//toddler = 22in
//bandCircumference=55.88
bandDiameter = bandCircumference / PI;
//crownPoints
crownPoint = bandCircumference/4;
crownDiag = crownPoint*1.41421;

module flatShape(){
	square([4*crownDiag, crownPoint]);
	translate([0*crownDiag,crownPoint,0]) rotate([0,0,-45]) square(crownPoint, center=false);
	translate([1*crownDiag,crownPoint,0]) rotate([0,0,-45]) square(crownPoint, center=false);
	translate([2*crownDiag,crownPoint,0]) rotate([0,0,-45]) square(crownPoint, center=false);
	translate([3*crownDiag,crownPoint,0]) rotate([0,0,-45]) square(crownPoint, center=false);
}

$fn=200;

module orientShape(){
//rotate(90)
//linear_extrude(1) 
flatShape();
}

//rotate_extrude() orientShape();
orientShape();