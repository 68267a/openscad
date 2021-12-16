$fn=200;

POLEHEIGHT = 50;
POLEDIAMETER = 5;
SLEEVEID = 5.25;
SLEEVEOD = 6;
RAMPLENGTH = 25;
RAMPANGLE = 6;
RAMPWIDTH = 5;
NUMRAMPS = 10;


module pole() {
	cylinder(
		h=POLEHEIGHT,
		d=POLEDIAMETER
	);
}

module ramp() {
	difference() {
		cylinder(
			h=RAMPLENGTH,
			d=RAMPWIDTH
			// center=true
		);
		translate([0,0,-1]) cylinder(
			h=RAMPLENGTH+2,
			d=RAMPWIDTH-1
			// center=true
		);
		translate([-RAMPWIDTH/2-1,0,-1]) cube([
			RAMPWIDTH+2,
			RAMPWIDTH,
			RAMPLENGTH+2]
			// ,center=true
		);
	}
}

module sleeve() {
	difference() {
		cylinder(
			h=SLEEVEID,
			d=SLEEVEOD
		);
		resize([SLEEVEID,SLEEVEID,0]) translate([0,0,-1]) pole();
		rotate([90+RAMPANGLE,0,0]) translate([0,SLEEVEID/1.5,0]) ramp();
	}
}

pole();
translate ([2*POLEDIAMETER,0,0]) rotate([0,0,0]) sleeve();
translate ([4*POLEDIAMETER,0,0]) ramp();