//snap fit connectors

// column width
w=20;
// main column height
h=10;
// snap fit width
s=2;
//snap fit height
f=2;
// mini column height
m=5;
// tolerance
t=0.5;

// $fn=100;

module snapfitA(){
	union(){
		translate([0,0,h/2+m])cylinder (r1=s, r2=1, h=f, center=true); //arrow head
		translate([0,0,h/2+m/2])cylinder(r=s-t, h=m, center=true); //mini column
	}
}

module snapfitB(){
	difference(){
		snapfitA();
		translate([0,0,h/2+m]) cube([s/3,s*2,f+m], center=true); //cut in snap fit
		translate([0,0,h/2+m]) rotate([0,0,90]) cube([s/3,s*2,f+m], center=true); //cut in snap fit
	}
}

translate([5,0,0]) snapfitA();
translate([0,0,0]) snapfitB();