$fn=200;

//unit conversion
	i2c = 25.4;
	c2i = 0.03937;

PAGEWIDTH			=	i2c * 4;
PAGEHEIGHT		= i2c * 6;
// PAGEDEPTH			= i2c * (1/16);
PAGEDEPTH			= 1;

TOGGLEWIDTH		= i2c * 1;
TOGGLEHEIGHT	= i2c * .5;
TOGGLEDEPTH		= i2c * .75;

TOGGLEPADDING = 4;
TOGGLESPACE		= TOGGLEPADDING + TOGGLEHEIGHT;
NUMTOGGLES		= floor(((PAGEHEIGHT * .9) - TOGGLESPACE) / TOGGLESPACE);

LINEPADDING		=	TOGGLEPADDING*2 + TOGGLEWIDTH;
LINELENGTH		=	PAGEWIDTH - (TOGGLEPADDING*2);

FRAMEWIDTH		= TOGGLEPADDING*3.5 + TOGGLEWIDTH + PAGEWIDTH;
FRAMEHEIGHT		= TOGGLEPADDING*2.5 + PAGEHEIGHT;
FRAMEDEPTH		= 4;

PAGEOFFSETX		= TOGGLEPADDING*2 + TOGGLEWIDTH;
PAGEOFFSETY		= TOGGLEPADDING*1.25;

module page(){
	color("white") cube([PAGEWIDTH, PAGEHEIGHT, PAGEDEPTH]);
}

module toggle(){
	cube([TOGGLEWIDTH, TOGGLEHEIGHT, TOGGLEDEPTH]);
}

module line(){
	translate([LINEPADDING,0,.75+FRAMEDEPTH+PAGEDEPTH]) 
	// rotate([0,180,0])
	rotate([0,90,0]) 
	{
		linear_extrude(LINELENGTH) {
			polygon([
			[.5,1],
			[.5,0],
			[1,.5]
			]);
		}
	}
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
	color("firebrick") cube([FRAMEWIDTH, FRAMEHEIGHT, FRAMEDEPTH]);
	translate([PAGEOFFSETX,PAGEOFFSETY,FRAMEDEPTH]) page();
}

// page();
toggles();
frame();