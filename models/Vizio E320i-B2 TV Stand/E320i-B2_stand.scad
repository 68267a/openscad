$fn=200;

// Triangle corners
A = 0;
B = 0;
C = 0;

// Triangle sides
X = 49;
Y = 54;
Z = 49;

// Mounting objects
// POSTS
D = 3.75;
E = 5.75;
Fx = 8;
Fy = 4;

module triangle(){
	linear_extrude(5){
		difference() {
			polygon([
				[0,0],
				[54,0],
				[27,47.5]
			]);
			corner=[[0,0],[10,0],[5,9]];
			translate([ 0,0]) polygon(corner);
			translate([44,0]) polygon(corner);
			translate([22,38.8]) polygon(corner);
		}
	}
}

module posts(){
  //10, 21, 29
	translate([27,10,2]) linear_extrude(5) circle(d=3.75);
	translate([27,21,-1]) linear_extrude(7) circle(d=5.75);
	translate([27,29,2]) linear_extrude(5) circle(d=3.75);
}

translate([12.5,0,5]) linear_extrude(5) square([8,4]);
translate([33.5,0,5]) linear_extrude(5) square([8,4]);

difference(){
	triangle();
	posts();
}