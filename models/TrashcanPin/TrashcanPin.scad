$fn=200;

SHAFTLENGTH = 101.5;
SHAFTDIAMETER = 20;
HOLLOWDIAMETER = 17;

CAPLENGTH = 3.5;
CAPDIAMETER = 29;

FLARELENGTH = 9;
FLAREDIAMETER = 24;
FLAREGAP = 8.5;

FLEXGAPWIDTH = 3;
FLEXGAPLENGTH = 16.5;
FLEXGAPHEIGHT = CAPDIAMETER;

module shaft(){
	linear_extrude(SHAFTLENGTH) circle(d=SHAFTDIAMETER);
}

module hollowshaft(){
	translate([00,00,CAPLENGTH+1])
	linear_extrude(SHAFTLENGTH)
	circle(d=HOLLOWDIAMETER);
}
module cap(){
	linear_extrude(CAPLENGTH) circle(d=CAPDIAMETER);
}

module flare() {
	translate([0,0,FLARELENGTH])
	rotate([180,0,0])
	cylinder(
		h=FLARELENGTH,
		d1=SHAFTDIAMETER,
		d2=FLAREDIAMETER
	);
}

module flexgap(){
	translate([00,00,CAPLENGTH+1]) 
	translate([0,0,FLEXGAPLENGTH/2])
	cube([FLEXGAPWIDTH, FLEXGAPHEIGHT, FLEXGAPLENGTH], center=true);
}

module solidpin(){
	union() {
		translate([00,00,00]) color("green") cap();
		translate([00,00,CAPLENGTH]) color("red") shaft();
		translate([00,00,FLAREGAP]) color("yellow") flare();
	}
}

//	color ("orange") hollowshaft();
//	color("blue") flexgap();
difference(){
	cube(10, center=true);
	cylinder(20,center=true);
}