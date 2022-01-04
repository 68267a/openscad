$fn=200;

RAMPLENGTH = 100; 4.5
RAMPANGLE = 6; 0.5
RAMPWIDTH = 25;
NUMRAMPS = 5;
SLEEVEID = 27;
SLEEVEOD = 30;
POLEHEIGHT = SLEEVEID*NUMRAMPS;
POLEDIAMETER = 25;


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
		#translate([0,0,-1]) cylinder(
			h=RAMPLENGTH+2,
			d=RAMPWIDTH*.85
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
		#rotate([90+RAMPANGLE,0,0]) translate([0,SLEEVEID/1.5,0]) ramp();
	}
}

difference() {
	pole();
	translate([-POLEDIAMETER/2,-POLEDIAMETER*1.2,-1]) cube([
		POLEDIAMETER,
		POLEDIAMETER,
		POLEHEIGHT+2
	]);
};
translate ([1.5*POLEDIAMETER,0,SLEEVEID]) rotate([180,0,180]) sleeve();
translate ([3*POLEDIAMETER,0,0]) rotate([0,0,180]) ramp();