
// include <bend.scad>;
// include <line3d.scad>;

$fn=200;

//set your measurement and unit.
	circumference = 165.1;
	unit = "cm"; // inch or cm
	printJewels=true; //set to false if you want to print jewels in a different color

//unit conversion
	i2c = 25.4;
	//c2i = 0.03937;
	bandCircumference = unit=="inch" ? circumference * i2c : circumference;
	//165.1/4+35.35=76.625

//adjustable settings
	//baby doll = 6.5in
	//toddler = 22in
	numberOfPoints = 4;
	crownPoint = 50;
	crownDiag = 35.35;
	crownHeight = bandCircumference/numberOfPoints+crownDiag;
	jewelHeight = 19.64;
	jewelRatio = .65;
	jewelBaseOffset = 10;
	jewelBaseDiameter = 1;


//calculated settings
	jewelOffset = 1.06;
	bandDiameter = bandCircumference / PI;
	bandRadius = bandDiameter/2;
	jewelWidth = jewelHeight*jewelRatio;
	jewelBaseX=jewelHeight*PI+jewelBaseOffset;
	jewelBaseY=jewelBaseDiameter*1.5;
	jewelBaseZ=jewelBaseY;


//bend areas
	cx = bandCircumference*1.2;
	cy = crownPoint;
	cz = 5;

///////////////////////////////////////////////////////////////////////

//DEBUG
crownInside();
jewelTrack();
jewel();
jewelBase();
jewels();
//END DEBUG

//crown();

module crown(){
	crownBody();
	jewelTrack();
	jewels();
}
///////////////////////////////////////////////////////////////////////

module crownInside(){
	linear_extrude(height=crownHeight) circle(d=bandDiameter);
}

module jewelTrack(){

}

module jewelBase(){

}

module jewel(){

}

module jewels(){
	if(!printJewels){
		translate([jewelWidth,0,0]) jewel();
		translate([-jewelWidth,0,0]) jewel();
	}
	translate([0,-bandRadius*jewelOffset,jewelHeight]) {
		rotate([90,0,0]) {
			if(printJewels) color("DeepPink") jewel();
		}
	}
	translate([bandRadius*jewelOffset,0,jewelHeight]) {
		rotate([90,0,90]){
			if(printJewels) color("RoyalBlue") jewel();
		}
	}
	translate([0,bandRadius*jewelOffset,jewelHeight]) {
		rotate([90,0,180]){
			if(printJewels) color("DeepPink") jewel();
		}
	}
	translate([-bandRadius*jewelOffset,0,jewelHeight]) {
		rotate([90,0,-90]){
			if(printJewels) color("RoyalBlue") jewel();
		}
	}
}
