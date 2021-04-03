
include <bend.scad>;
include <line3d.scad>;

$fn=200;

printJewels=true;

//unit conversion
//1 inch = 25.4 cm
//1 cm = 0.03937 inch

//crown is basically a rectangle with 4 diagonal squares
//measurements
	//baby doll = 6.5in
	bandCircumference=165.1;
	//toddler = 22in
	//bandCircumference=558.8;
	bandDiameter = bandCircumference / PI;
	bandRadius = bandDiameter/2;
	crownPoint = bandCircumference/4*1.2;
	crownDiag = crownPoint/1.41421;
	jewelHeight = crownDiag/1.9;
	jewelRatio = .65;
	jewelWidth = jewelHeight*jewelRatio;


//bend areas
	//crown()
		cx = bandCircumference*1.2;
		cy = crownPoint;
		cz = 5;

	//jewelBase()
		jewelBaseOffset=10;
		jewelBaseX=jewelHeight*PI+jewelBaseOffset;
		jewelBaseDiameter=1;
		jewelBaseY=jewelBaseDiameter*1.5;
		jewelBaseZ=jewelBaseY;

module crown(){
	// translate([cx/2,2*cy,0]) {
		rotate([0,0,45]) 
			bend(size=[cx, cy, cz], angle=360, frags=200) {
				difference() {
					crownBody();
					jewelTrack();
				}
				//jewelBase();
				//NO! NOT HERE! jewels();
			}
		
	}
// }

module crownBody(){
	color("gold")
	linear_extrude(2){
		translate([0,0,1]){
			square([bandCircumference*1.2, crownPoint/2]);
			translate([0*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
			translate([1*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
			translate([2*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
			translate([3*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
		}

		square([bandCircumference*1.2, crownPoint/2]);
		translate([0*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
		translate([1*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
		translate([2*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
		translate([3*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
	}
}

module jewelTrack(){
	p3=crownPoint/2.75;
	color("goldenrod")
	line3d(
		p1=[0, p3, 2],
		p2=[bandCircumference*1.2, p3, 2],
		diameter=2,
		$fn=24
	);
}

module jewelBase(){
	translate([0,-jewelBaseDiameter,-jewelBaseDiameter]) {
		translate([0,jewelBaseDiameter,0]) {	
			line3d(
				p1=[0, jewelBaseY, jewelBaseZ],
				p2=[jewelBaseX, jewelBaseY, jewelBaseZ],
				diameter=jewelBaseDiameter,
				$fn=24
			);
		}
		translate([0,jewelBaseDiameter,jewelBaseDiameter])
		cube([jewelBaseX,jewelBaseY,jewelBaseDiameter]);
	}
}

module bendJewelBase(){
	bend(size=[jewelBaseX, jewelBaseY+jewelBaseDiameter, jewelBaseDiameter], angle=360, frags=200)
	jewelBase();
}

module scaleBentJewelBase(){
	scale([jewelRatio,1,1])
	bendJewelBase();
}

module jewel(){
	difference(){
		resize(newsize=[jewelWidth,jewelHeight,cz]) 
			sphere(r=1);
		translate([-jewelWidth/2,-jewelHeight/2,-cz/2])
			cube([jewelWidth,jewelHeight,cz/2]);
	}
}
module jewels(){
	if(!printJewels){
		translate([jewelWidth,0,0]) jewel();
		translate([-jewelWidth,0,0]) jewel();
	}
	translate([0,-bandRadius*1.02,jewelHeight]) {
		rotate([90,0,0]) {
			color("goldenrod") scaleBentJewelBase();
			if(printJewels) color("DeepPink") jewel();
		}
	}
	translate([bandRadius*1.02,0,jewelHeight]) {
		rotate([90,0,90]){
			color("goldenrod") scaleBentJewelBase();
			if(printJewels) color("RoyalBlue") jewel();
		}
	}
	translate([0,bandRadius*1.02,jewelHeight]) {
		rotate([90,0,180]){
			color("goldenrod") scaleBentJewelBase();
			if(printJewels) color("DeepPink") jewel();
		}
	}
	translate([-bandRadius*1.02,0,jewelHeight]) {
		rotate([90,0,-90]){
			color("goldenrod") scaleBentJewelBase();
			if(printJewels) color("RoyalBlue") jewel();
		}
	}
}

crown();
jewels();
