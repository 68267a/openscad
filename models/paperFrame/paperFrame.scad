$fn=200;

// main base object
	bx = 140;
	by = 180;
	bz = 2.5;
// frame rails
	rx = 10;
	rz = 5.4;

module base(){
	square([bx,by]);
}

module rail(ry){
	difference(){
		translate([rz,0,0]) circle(rz);
		square(2*rz);
	}
}

module railCorners(){
	// linear_extrude(height=rx*0.79) 
	a=7.9;
	b=.5;
#	translate([b,b,4]) sphere(a);
	cube(a);
}


linear_extrude(height=bz) base();
translate([0,rx+.8,bz]) rotate([-90,0,-90]) linear_extrude(height=bx) rail(by);
translate([0,by,bz]) rotate([-90,0,-90]) linear_extrude(height=bx) rail(by);
translate([0,0,bz]) rotate([-90,0,0]) linear_extrude(height=by) rail(by);
translate([bx-2*rz,0,bz]) rotate([-90,0,0]) linear_extrude(height=by) rail(by);
railCorners();