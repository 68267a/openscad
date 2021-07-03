$fn=200;

//measurement/unit settings
	//baby doll = 6.5in = 165.1cm
	//toddler = 22in = 558.8cm
	circumference = 500;
	unit = "cm"; // inch or cm
	printJewels=false; //set to false if you want to print jewels in a different color
//end measurement/unit settings

//unit conversion
	i2c = 25.4;
	c2i = 0.03937;
	bandCircumference = unit=="inch" ? circumference * i2c : circumference;
//unit conversion

//calculated settings
	bandThickness		= circumference*0.018;
	crownHeight			= circumference*0.300;
	crownPoint			= circumference*0.262; //rotate 45
	jewelHeight			= circumference*0.121;
	jewelZLift			=	circumference*0.056;
	jewelBaseHeight	= circumference*0.161;
	jewelBaseZLift	= circumference*0.035;
	jewelTrack			= circumference*0.016;
	jewelTrackZLift	= circumference*0.115;
//calculated settings


module crownBody(){
	difference(){
		//CROWN BODY
		linear_extrude(height=crownHeight) circle(d=bandDiameter);
		translate([0,0,-2]) linear_extrude(height=crownHeight+5) circle(d=bandDiameter-bandThickness);

		//CROWN POINTS
		translate([-bandDiameter/2,0,crownHeight]) {
			rotate([45,0,0]) 
			rotate([0,90,0]) 
			linear_extrude(height=bandDiameter+5) 
			square(bandDiameter/2, center=true);
		}
		translate([0,bandDiameter/2,crownHeight]) {
			rotate([0,45,0])
			rotate([90,0,0])
			linear_extrude(height=bandDiameter+5)
			square(bandDiameter/2, center=true);
		}
	}
}
//jewel, jewelBase, jewelTrack

module jewel(){
	scale([.67,1,.64]) {
		rotate_extrude() {
			intersection(){
				circle(jewelZ);
				square(jewelY);
			}
		}
	}
}


module jewelBase(){
	translate([0,0,jewelBaseDiameter])
	difference() {
		scale([1.1,1.1,.33]) jewel();
		translate([0,0,.1]) jewel();
	}
	linear_extrude(jewelBaseDiameter) projection() translate([0,0,jewelBaseDiameter]) scale([1.1,1.1,.33]) jewel();
	//needs a platform. Shadow/projection?
}
translate([0,0,jewelX]) rotate([90,0,0]) jewelBase();
#rotate([0,0,45]) crownBody();