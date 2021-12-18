$fn=200;

BALLDIAMETER = 4.3;
BALLRADIUS=BALLDIAMETER/2;
BALLGAP=10;
RAMPLENGTH = 107.1;
RAMPANGLE = 1.25;
NUMRAMPS = 5;
POLEHEIGHT = BALLGAP*NUMRAMPS+BALLGAP;

module ball(){
	color("silver") sphere(BALLRADIUS);
}

module rampshape(){
	polygon(points=[
		[0,7],
		[BALLRADIUS-.25,BALLDIAMETER],
		[1.8,3],
		[3,1],
		[BALLDIAMETER,BALLRADIUS-.25],
		[6,1],
		[6.8,3],
		[BALLDIAMETER+BALLRADIUS+.25,BALLDIAMETER],
		[9,7],
		[9,0],
		[0,0],
		[0,7]
	]);
}

module ramp(){
	linear_extrude(height=RAMPLENGTH) rampshape();
}

module basepolehole(){
	square([BALLGAP/4,BALLGAP-1]);
}
module rampmount(){
	difference() {
		linear_extrude(height=BALLGAP) square(BALLGAP+1);
		translate([1,1,BALLGAP/2]) rotate([RAMPANGLE,0,0]) ramp();
		translate([2,3,1.5]) rotate([90,0,0]) peg();
		translate([6,3,1.5]) rotate([90,0,0]) peg();
		translate([2,14,1.5]) rotate([90,0,0]) peg();
		translate([6,14,1.5]) rotate([90,0,0]) peg();
	}
}

module peg() {
	cube([3,3,6]);
}

module base(){
difference() {
		linear_extrude(height=RAMPLENGTH/2+3*BALLGAP) square(11);
		translate([3,10,17]) sphere(BALLRADIUS+3);
		translate([1,1,80.6]) peg();
		translate([1,6,80.6]) peg();
		translate([6,1,80.6]) peg();
		translate([6,6,80.6]) peg();
		translate([2,8,4.5]) rotate([270,0,0]) peg();
		translate([6,8,4.5]) rotate([270,0,0]) peg();

	}
}
module basepole(){
	linear_extrude(height=POLEHEIGHT) basepolehole();
}

module polespacer(){
	linear_extrude(height=BALLGAP) square([10,11]);
}

//translate([25,5.4,16]) ball();
translate([0,0,0]) rotate([90,0,90]) base();

// translate([1,1,1]) rotate([0,0,0]) basepole();
// translate([133.6,1,1]) rotate([0,0,0]) basepole();

translate([0,20,0]) rotate([0,0,0]) rampmount();

translate([0,-5,0]) peg();
translate([0,-20,0]) rotate([90,0,90]) ramp();