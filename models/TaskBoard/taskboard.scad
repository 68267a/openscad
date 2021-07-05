$fn=200;

// use "lib/fonts/Vampire Kiss Demo/fonts/Vampire Kiss Demo.ttf";
//TODO: left/right hand
//TODO: make toggle boxes less ugly
//TODO: paper lines should be grooves
//TODO: paper inserts

//unit conversion
	i2c = 25.4;
	c2i = 0.03937;

HAND = "both"; //right|left|both
PAGE_X	=	i2c * 4;
PAGE_Y	= i2c * 6;
// PAGE_Z			= i2c * (1/16);
PAGE_Z	= 1;

TOGGLE_X	= 31	; //x
TOGGLE_Y	= 12.3; //y
TOGGLE_Z	= 31	; //z

TOGGLEPADDING = 4;
TOGGLESPACE		= TOGGLEPADDING + TOGGLE_Y;
NUMTOGGLES		= floor(((PAGE_Y * .9) - TOGGLESPACE) / TOGGLESPACE);

LINEPADDING	=	TOGGLEPADDING*2 + TOGGLE_X;
LINELENGTH	=	PAGE_X - (TOGGLEPADDING*2);

FRAME_X	= TOGGLEPADDING*3.5 + TOGGLE_X + PAGE_X;
FRAME_Y	= TOGGLEPADDING*2.5 + PAGE_Y;
FRAME_Z	= 4;

PAGEOFFSET_X	= TOGGLEPADDING*2;
PAGEOFFSET_Y	= TOGGLEPADDING*1.25;

module page(){
  difference() {
		color("white") cube([PAGE_X, PAGE_Y, PAGE_Z]);
		linear_extrude(3*PAGE_Z)
			translate([PAGEOFFSET_X+TOGGLEPADDING,TOGGLESPACE*NUMTOGGLES+TOGGLESPACE+1,1]) 
			text("Daily Chores", font = "Vampire Kiss Demo");
	}
}

module toggle(){
	cube([TOGGLE_X, TOGGLE_Y, TOGGLE_Z]);
}

module line(){
	translate([LINEPADDING,0,.75+FRAME_Z+PAGE_Z]) 
	rotate([0,90,0]) linear_extrude(LINELENGTH) polygon([[.5,1],[.5,0],[1,.5]]);
}

module toggles(){
	translate([TOGGLEPADDING,0,0])
	for( i = [1:1:NUMTOGGLES]) {
		translate([0,TOGGLESPACE*i,0]) {
			color("gray") toggle();
			color("orange") line();
		}
	}
	// header line
	translate([TOGGLEPADDING,TOGGLESPACE*NUMTOGGLES+TOGGLESPACE+1,0]) line();
}

module frame(){
	if (HAND=="left"){
		translate([FRAME_X,0,0]) mirror([1,0,0]) toggles();
		translate([PAGEOFFSET_X,PAGEOFFSET_Y,FRAME_Z]) page();
		color("firebrick") cube([FRAME_X, FRAME_Y, FRAME_Z]);
	} else if (HAND=="both"){
		toggles();
		translate([FRAME_X+TOGGLE_X,0,0]) mirror([1,0,0]) toggles();
		translate([PAGEOFFSET_X + TOGGLE_X,PAGEOFFSET_Y,FRAME_Z]) page();
		color("firebrick") cube([FRAME_X+TOGGLE_X, FRAME_Y, FRAME_Z]);
	} else {
		toggles();
		translate([PAGEOFFSET_X + TOGGLE_X,PAGEOFFSET_Y,FRAME_Z]) page();
		color("firebrick") cube([FRAME_X, FRAME_Y, FRAME_Z]);
	}
}

frame();