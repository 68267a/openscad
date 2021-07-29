$fn=200;
// use "lib/fonts/Vampire Kiss Demo/fonts/Vampire Kiss Demo.ttf";
// for(day = DAYS) echo(day[0]);

TRAY_XY=60;
TRAY_Z=1;
TRAY_MARGIN=2;

LABEL_X = TRAY_XY;
LABEL_Y = 20;
LABEL_Z = TRAY_Z;

DAYS=[["Sunday"],["Monday"],["Tuesday"],["Wednesday"],["Thursday"],["Friday"],["Saturday"]];

module dayLabel(v) {
	let(i=0) {
		difference() {
			translate([0,i*(LABEL_Y+5),0]) cube([LABEL_X,LABEL_Y,TRAY_Z]);
			color("firebrick") translate([TRAY_MARGIN,2+i*(LABEL_Y+5)+2,-0.5]) linear_extrude(TRAY_Z+2) text(v, font = "Vampire Kiss Demo");
		}
	}
	let (i=1) {
		translate([0,i*(LABEL_Y+5),0]) cube([LABEL_X,LABEL_Y,TRAY_Z]);
		color("firebrick") translate([TRAY_MARGIN,2+i*(LABEL_Y+5)+2,0]) linear_extrude(TRAY_Z+1) text(v, font = "Vampire Kiss Demo");
	}

}

module dayTray(){
	color("white") cube([TRAY_XY,TRAY_XY,TRAY_Z]);
	color("gray")  cube([TRAY_MARGIN,TRAY_XY,TRAY_MARGIN]);
	translate([TRAY_XY,0,0]) color("orange")  cube([TRAY_MARGIN,TRAY_XY,TRAY_MARGIN]);
}

for (i = [0:1:len(DAYS)-1]) {
	translate([TRAY_XY*i,0,0]) dayTray();
	translate([TRAY_XY*i+TRAY_MARGIN,TRAY_XY, 0]) dayLabel(DAYS[i][0]);
}