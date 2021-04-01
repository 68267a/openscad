// keystand

toothgap=13;
toothwidthS=3;
toothwidthR=4;
toothlength=10;
length=62;
height=5;
handle=25;
armwidth=6;
keyring=5;

module keystand(){
	//handle
	difference() {
		circle(d=handle);
		translate([-handle/3,0]) circle(d=keyring);
	}
	//body
	translate([length/2,0,0]) square([length,armwidth],center=true);
	translate([length,0,0]) circle(d=armwidth*1.05);

	//square teeth
	//#translate([length,0,0]) rotate([0,0,270]) square([toothlength,toothwidthS]);
	//#translate([length-toothgap,0,0]) rotate([0,0,270]) square([toothlength,toothwidthS]);
}

linear_extrude(height = 4)
keystand();

//round teeth
#translate([length,0,height/2.5]) rotate([90,0,0]) cylinder(h=toothlength,d=toothwidthR, $fn=200);
#translate([length-toothgap,0,height/2.5]) rotate([90,0,0]) cylinder(h=toothlength,d=toothwidthR, $fn=200);