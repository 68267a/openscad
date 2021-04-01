
include <bend.scad>;

//unit conversion
//1 inch = 25.4 cm
//1 cm = 0.03937 inch

//crown is a rectangle with 4 diagonal squares
//baby doll = 6.5in
bandCircumference=165.1;
//toddler = 22in
//bandCircumference=558.8
bandDiameter = bandCircumference / PI;
//crownPoints
crownPoint = bandCircumference/4;
crownDiag = crownPoint/1.41421;

module flatShape(){
	square([bandCircumference, crownPoint/2]);
	translate([0*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
	translate([1*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
	translate([2*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
	translate([3*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
}

$fn=200;
x = bandCircumference;
y = crownPoint;
z = 1;

translate([-bandDiameter/2, -crownPoint/2,0])
  *cube(size = [bandDiameter, y, z]);

bend(size = [x, y, z], angle = 360, frags = 360)
    linear_extrude(z) 
        flatShape();