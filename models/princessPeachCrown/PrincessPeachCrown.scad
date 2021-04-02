
include <bend.scad>;
include <line3d.scad>;

$fn=200;

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
	crownPoint = bandCircumference/4;
	crownDiag = crownPoint/1.41421;
	jewelHeight = crownDiag/1.5;
	jewelRatio = .65;
	jewelWidth = jewelHeight*jewelRatio;

//bend areas
	//crown()
		cx = bandCircumference;
		cy = crownPoint;
		cz = 5;
	//jewelBase()
		jBx=20;
		jBy=1;
		jBz=5;

module crownBody(){
	color("gold")
	linear_extrude(2){
		translate([0,0,1]){
			square([bandCircumference, crownPoint/2]);
			translate([0*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
			translate([1*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
			translate([2*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
			translate([3*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
		}

		square([bandCircumference, crownPoint/2]);
		translate([0*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
		translate([1*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
		translate([2*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
		translate([3*crownPoint,crownPoint/2,0]) rotate([0,0,-45]) square(crownDiag, center=false);
	}
}

module jewelTrack(){
	//translate([0,crownPoint/3.7,2])
	p3=crownPoint/2.75;
	color("goldenrod")
	line3d(
		p1=[0, p3, 2],
		p2=[bandCircumference, p3, 2],
		diameter=2,
		$fn=24
	);
}

module jewelBase(){
	p1=[0,jBy,jBz];
	p2=[jBx,jBy,jBz];
	diameter=2;

	bend(size=[jBx, jBy, 2*jBz], angle=90, frags=200) {
		//cube([jBx,diameter,diameter]);
		line3d(p1, p2, diameter=diameter,$fn=24);
	}
}


module jewel(){
	resize(newsize=[jewelWidth,jewelHeight,5]) 
	sphere(r=1);
}

module jewels(){
	color("DeepPink")  translate([1*crownPoint/2,jewelHeight*.85,1.5]) jewel();
	color("RoyalBlue") translate([3*crownPoint/2,jewelHeight*.85,1.5]) jewel();
	color("DeepPink")  translate([5*crownPoint/2,jewelHeight*.85,1.5]) jewel();
	color("RoyalBlue") translate([7*crownPoint/2,jewelHeight*.85,1.5]) jewel();
}

module crown(){
	translate([cx/2,2*cy,0]) {
		rotate([0,0,-135]) {
			bend(size=[cx, cy, cz], angle=360, frags=200) {
				difference() {
					crownBody();
					jewelTrack();
				}
				// jewelBase();
				//NO! NOT HERE! jewels();
			}
		}
	}
}

translate([20,0,0]){
	crown();
	//debug
	%cube([cx,cy,cz]);
	crownBody();
	jewelTrack();
	jewels();
}

jewelBase();
//resize(newsize=[jewelWidth,jewelHeight,5]) jewelBase();