
// include <bend.scad>;
// include <line3d.scad>;

$fn=200;

//measurement/unit settings
	//baby doll = 6.5in = 165.1cm
	//toddler = 22in = 558.8cm
	circumference = 165.1;
	unit = "cm"; // inch or cm
	printJewels=true; //set to false if you want to print jewels in a different color
//end measurement/unit settings

//unit conversion
	i2c = 25.4;
	c2i = 0.03937;
	bandCircumference = unit=="inch" ? circumference * i2c : circumference;
//unit conversion

//adjustable settings
	bandThickness = 3;
	pointX = 20;
	pointY = 25;
	crownHeight = 50;
	jewelRatio = .65;
	jewelX = 14;
	jewelY = 21;
	jewelZ = 9;
	jewelBaseX=15;	
	jewelBaseY=22;	
	jewelBaseZ=10;	
	jewelBaseOffset = 10;
	jewelBaseDiameter = 1;

//calculated settings
	jewelOffset = 1.06;
	bandDiameter = bandCircumference / PI;
	bandRadius = bandDiameter/2;

///////////////////////////////////////////////////////////////////////
//DEBUG
	*%translate([bandDiameter,0,0]) point();
	*%crownNegative();
	*%crownPoint();
	*%crownPoints();
	%translate([bandDiameter,0,1]) jewel();
	#%translate([bandDiameter,0,0]) jewelBaseNegative();
//END DEBUG
///////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
//WORK AREA
	module jewel(){
		difference(){
			resize(newsize=[jewelX,jewelY,jewelZ]) 
				sphere(r=1);
			translate([-jewelX/2,-jewelY/2,-jewelZ/2])
				cube([jewelX,jewelY,jewelZ/2]);
		}
	}

	module jewelBaseNegative(){
		translate([0,0,0.5])
		resize(newsize=[jewelX,jewelY,jewelZ]) 
			circle(1);
	}


//END WORK AREA
///////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
//MISC MODULES
	module crownNegative(){
		translate([0,0,-2.5]) linear_extrude(height=crownHeight+5) circle(d=bandDiameter);
	}

	module crownBody(){
		difference() {
			linear_extrude(height=crownHeight) circle(d=bandDiameter+bandThickness);
			crownPoints();
			crownNegative();
		}
	}

	module point(){
		//square(crownDiag, center=true);
		polygon(points=[
			[pointX,0],
			[0,pointY],
			[-pointX,0],
			[0,-pointY],
		]);
	}

	module crownPoint(){
		translate([0,bandDiameter*1.2/2,crownHeight])
		rotate([90,0,0])
			linear_extrude(height=bandDiameter*1.2)
				//rotate([0,0,-45]) 
					point();
	}

	module crownPoints(){
		crownPoint();
		rotate([0,0,90]) crownPoint();
	}

	module jewelTrack(){

	}

	module jewels(){
		if(!printJewels){
			translate([jewelX,0,0]) jewel();
			translate([-jewelX,0,0]) jewel();
		}
		translate([0,-bandRadius*jewelOffset,jewelY]) {
			rotate([90,0,0]) {
				if(printJewels) color("DeepPink") jewel();
			}
		}
		translate([bandRadius*jewelOffset,0,jewelY]) {
			rotate([90,0,90]){
				if(printJewels) color("RoyalBlue") jewel();
			}
		}
		translate([0,bandRadius*jewelOffset,jewelY]) {
			rotate([90,0,180]){
				if(printJewels) color("DeepPink") jewel();
			}
		}
		translate([-bandRadius*jewelOffset,0,jewelY]) {
			rotate([90,0,-90]){
				if(printJewels) color("RoyalBlue") jewel();
			}
		}
	}
//END MISC MODULES
///////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
//MAIN
	crown();
	module crown(){
		rotate([0,0,45]) crownBody();
		//jewelTrack();
		//jewelBase();
		//jewels();
	}
//END MAIN
///////////////////////////////////////////////////////////////////////