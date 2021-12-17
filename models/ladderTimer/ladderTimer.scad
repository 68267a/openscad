$fn=200;

RAMPLENGTH = 107.1;
RAMPANGLE = 1.25;
RAMPWIDTH = 15;
NUMRAMPS = 5;
SLEEVEID = 17;
SLEEVEOD = 19;
POLEHEIGHT = SLEEVEID*NUMRAMPS;
POLEDIAMETER = 15;
BASEHEIGHT = SLEEVEID;
BALLDIAMETER = 10;


module pole() {
	cylinder(
		h=POLEHEIGHT,
		d=POLEDIAMETER
	);
}

module posthole() {
	difference() {
		cylinder(
			h=BASEHEIGHT,
			d=POLEDIAMETER*1.1
		);
		difference() {
			pole();
			translate([-POLEDIAMETER/2,-POLEDIAMETER*1.2,-1]) cube([
				POLEDIAMETER,
				POLEDIAMETER,
				POLEHEIGHT+2
			]);
		}
	}
}	

module base() {
	translate([-(RAMPLENGTH*1.1)/2,0,0]) rotate([0,0,90]) posthole();
	translate([(RAMPLENGTH*1.1)/2,0,0]) rotate([0,0,-90]) posthole();
	difference() {
		translate([-(RAMPLENGTH*1.05)/2,-RAMPWIDTH/2,0]) cube([RAMPLENGTH*1.05,RAMPWIDTH,10]);
		translate([-(RAMPLENGTH*.9)/2,0,8]) rotate([0,90,0]) cylinder(h=RAMPLENGTH*.9, d=BALLDIAMETER);
		translate([0,-BALLDIAMETER/2,BALLDIAMETER*.75]) rotate([90,0,0]) cylinder(h=BALLDIAMETER,d=BALLDIAMETER, center=true);
	}
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
		rotate([90+RAMPANGLE,0,0]) translate([0,SLEEVEID/1.5,0]) ramp();
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

translate([0,25,0]) base();