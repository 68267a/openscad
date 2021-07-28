$fn=200;

// use "lib/fonts/Vampire Kiss Demo/fonts/Vampire Kiss Demo.ttf";
//TODO: left/right hand
//TODO: make toggle boxes less ugly
//TODO: paper lines should be grooves
//TODO: paper inserts

//unit conversion
	i2c = 25.4;
	c2i = 0.03937;

HAND 					= "right";		//right|left|both

PAGE_X				=	i2c * 4;	//4"x6"
PAGE_Y				= i2c * 6;
PAGE_Z				= i2c * (1/32);

TOGGLEHOLE_X	= 31	; //x
TOGGLEHOLE_Y	= 12.3; //y
TOGGLEHOLE_Z	= 21	; //z
TOGGLEPADDING = 4;

TOGGLEMOUNT_X = TOGGLEHOLE_X + TOGGLEPADDING;
TOGGLEMOUNT_Y	=	TOGGLEHOLE_Y + TOGGLEPADDING+1;
TOGGLEMOUNT_Z	=	TOGGLEHOLE_Z + TOGGLEPADDING;

TOGGLESPACE		= TOGGLEPADDING + TOGGLEHOLE_Y;
NUMTOGGLES		= floor(((PAGE_Y * .9) - TOGGLESPACE) / TOGGLESPACE);

LINEPADDING		=	TOGGLEPADDING*2 + TOGGLEHOLE_X;
LINELENGTH		=	PAGE_X - (TOGGLEPADDING*2);

FRAME_X				= TOGGLEHOLE_X+TOGGLEPADDING+PAGE_X;
FRAME_Y				= TOGGLEHOLE_Y + TOGGLESPACE;
FRAME_Z				= 4;

PAGEOFFSET_X	= TOGGLEPADDING*2;
PAGEOFFSET_Y	= TOGGLEPADDING*1.25;

module line(){
	rotate([0,90,0]) 
	linear_extrude(LINELENGTH) 
	polygon([[.5,1],[.5,0],[1,.5]]);
}

module page(){
	difference() {
		color("white") cube([PAGE_X, PAGE_Y/NUMTOGGLES,PAGE_Z]);
		#translate([TOGGLEPADDING,TOGGLEPADDING/2,1.5]) line();
	}
}

module toggle(){
	difference(){
		cube([TOGGLEHOLE_X+TOGGLEPADDING, PAGE_Y/NUMTOGGLES, TOGGLEHOLE_Z]);
		translate([TOGGLEPADDING/2,TOGGLEPADDING,TOGGLEPADDING/2]) cube([TOGGLEHOLE_X, TOGGLEHOLE_Y, TOGGLEHOLE_Z]);
	}
}

module frame(){
	color("firebrick") cube([PAGE_X + TOGGLEMOUNT_X, PAGE_Y/NUMTOGGLES, FRAME_Z]);
}


module chartModule(){
	resize([]) frame();
	translate([TOGGLEMOUNT_X,0,FRAME_Z]) page();
	translate([0,0,0]) toggle();
}

module chartHeader(){
	// frame();
  translate([0,0,FRAME_Z]) difference() {
		color("white") cube([PAGE_X, PAGE_Y/NUMTOGGLES, PAGE_Z]);
		linear_extrude(3*PAGE_Z)
			translate([2*PAGEOFFSET_X+TOGGLEPADDING,TOGGLESPACE/2,1]) 
			// PAGEOFFSET_X+TOGGLEPADDING,TOGGLESPACE+TOGGLESPACE+1
			text("Daily Chores", font = "Vampire Kiss Demo");
	}
}

module chartModules(){
	chartModule();
	for( i = [1:1:NUMTOGGLES]) {
		translate([0,TOGGLESPACE*i,0]) chartModule();
	}
}

if (HAND=="left"){
	translate([0,PAGE_Y-TOGGLEMOUNT_Y,0]) chartHeader();
	translate([0,PAGE_Y-TOGGLEMOUNT_Y,0]) frame();
	translate([FRAME_X,0,0]) mirror([1,0,0]) chartModules();
} else if (HAND=="both"){
// Put the toggles on both sides
	translate([TOGGLEHOLE_X+TOGGLEPADDING,PAGE_Y-TOGGLEMOUNT_Y,0]) chartHeader();
	translate([0,PAGE_Y-TOGGLEMOUNT_Y,0]) frame();
	translate([TOGGLEHOLE_X+TOGGLEPADDING,PAGE_Y-TOGGLEMOUNT_Y,0]) frame();
	translate([0,0,0]) mirror([0,0,0]) chartModules();
	translate([TOGGLEHOLE_X+TOGGLEPADDING+FRAME_X,0,0]) mirror([1,0,0]) chartModules();
} else {
	translate([TOGGLEHOLE_X+TOGGLEPADDING,PAGE_Y-TOGGLEMOUNT_Y,0]) chartHeader();
	translate([0,PAGE_Y-TOGGLEMOUNT_Y,0]) frame();
	chartModules();
}
// 	if (HAND=="left"){
// 		translate([FRAME_X,0,0]) mirror([1,0,0]) toggles();
// 		translate([PAGEOFFSET_X,PAGEOFFSET_Y,FRAME_Z]) page();
// 		color("firebrick") cube([FRAME_X, FRAME_Y, FRAME_Z]);
// 	} else if (HAND=="both"){
// 		toggles();
// 		translate([FRAME_X+TOGGLEHOLE_X,0,0]) mirror([1,0,0]) toggles();
// 		translate([PAGEOFFSET_X + TOGGLEHOLE_X,PAGEOFFSET_Y,FRAME_Z]) page();
// 		color("firebrick") cube([FRAME_X+TOGGLEHOLE_X, FRAME_Y, FRAME_Z]);
// 	} else {
// 		toggles();
// 		translate([PAGEOFFSET_X + TOGGLEHOLE_X,PAGEOFFSET_Y,FRAME_Z]) page();
// 		color("firebrick") cube([FRAME_X, FRAME_Y, FRAME_Z]);
// 	}

// frame();