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
	jewelBaseX= circumference*0.09;
	jewelBaseY= circumference*0.13;
	jewelBaseZ= circumference*0.06;
	jewelBaseOffset = circumference*0.06;
	jewelBaseDiameter = circumference*0.006;
	jewelNotchH=circumference*0.006;
	jewelNotchR=circumference*0.004;
	jewelOffset=circumference*0.0064;
	bandDiameter = bandCircumference / PI;
	bandRadius = bandDiameter/2;

///////////////////////////////////////////////////////////////////////
//DEBUG
	// *%translate([bandDiameter,0,0]) point();
	// *%crownNegative();
	// *%crownPoint();
	// *%crownPoints();
	// translate([10,0,0]) rotate([180,0,0]) jewelNotched();
	jewelBaseNotched();
//END DEBUG
///////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
//WORK AREA

///////////////////////////////////////////////////////////////////////
//JEWELS
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

	module jewelNotch(){
		cylinder(h=jewelNotchH,r=jewelNotchR);
		translate([0,0,1]) 
		sphere(jewelNotchR);

		translate([0,-0.25,0])
		rotate([90,0,270])
		rotate_extrude(angle=90, $fn=7)
		translate([1, 0, 0])
		square(1, center=true);
	}

	module jewelNotches(){
		translate([0,3,0]) jewelNotch();
		translate([2,-3,0]) jewelNotch();
		translate([-2,-3,0]) jewelNotch();
	}


	module jewelNotched(){
		difference(){
			translate([0,0,.1]) jewel();
			jewelNotches();
		}
	}

	module jewels(){
		if(!printJewels) translate([jewelX,0,0]) jewelNotched();

		translate([0,-bandRadius*jewelOffset,jewelY]) {
			rotate([90,0,0]) {
				if(printJewels) color("DeepPink") jewelNotched();
				jewelBaseNotched();
			}
		}
		translate([bandRadius*jewelOffset,0,jewelY]) {
			rotate([90,0,90]){
				if(printJewels) color("RoyalBlue") jewelNotched();
				jewelBaseNotched();
			}
		}
		translate([0,bandRadius*jewelOffset,jewelY]) {
			rotate([90,0,180]){
				if(printJewels) color("DeepPink") jewelNotched();
				jewelBaseNotched();
			}
		}
		translate([-bandRadius*jewelOffset,0,jewelY]) {
			rotate([90,0,-90]){
				if(printJewels) color("RoyalBlue") jewelNotched();
				jewelBaseNotched();
			}
		}
	}
//END JEWELS
///////////////////////////////////////////////////////////////////////

//END WORK AREA
///////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
//CROWN
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
//END CROWN
///////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////
//JEWEL BASE

	module jewelBase(){
		difference() {
			scale([1.1,1.1,.33]) jewel();
			translate([0,0,.1]) jewel();
		}
	}

	module jewelBaseNotched(){
		jewelBase();
		rotate([180,0,0]) jewelBase();
		scale([1.01,1.01,1]) 
		jewelNotches();
	}

//JEWEL BASE
///////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
//MAIN

	crown();
	module crown(){
		rotate([0,0,45]) crownBody();
		//jewelTrack();
		jewels();
	}

//END MAIN
///////////////////////////////////////////////////////////////////////