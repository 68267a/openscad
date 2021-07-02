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

//adjustable settings
	jewelRatio = .65;

//calculated settings
	bandThickness = circumference*0.018;
	pointX = circumference*0.12;
	pointY = circumference*0.15;
	crownHeight = circumference*0.30;
	jewelX = circumference*0.085;
	jewelY = circumference*0.12;
	jewelZ = circumference*0.05;
	jewelBaseX = circumference*0.09;
	jewelBaseY = circumference*0.13;
	jewelBaseZ = circumference*0.06;
	jewelBaseOffset = circumference*0.06;
	jewelBaseDiameter = circumference*0.006;
	jewelNotchH = circumference*0.006;
	jewelNotchR = circumference*0.004;
	jewelOffset = circumference*0.0064;
	bandDiameter = bandCircumference / PI;
	bandRadius = bandDiameter/2;

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

//jewel();

module jewelBase(){
	difference() {
		scale([1.1,1.1,.33]) jewel();
		translate([0,0,.1]) jewel();
	}
	//needs a platform. Shadow/projection?
}

//rotate([90,0,0]) 
	jewelBase();

crownBody();