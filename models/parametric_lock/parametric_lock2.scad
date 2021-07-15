bitting = [3,10,4,5];

tol = 0.7;

plug_r = 12.5;

pin_r = 2;
pin_s = 4;

keyway_w = 5;
keyway_h = 17;

key_handle_r = 17;
key_hole_r = 3;

key_thickness = keyway_w-(2*tol);

tooth_space = keyway_h/2-tol;
tooth_unit = tooth_space/10;

pins = len(bitting);

key_channel_w = 2;
key_channel_off = 3;

clip_channel_w = 7;
clip_channel_d = 2;
clip_channel_off = 6;

plug_h = (((2*pin_r)+pin_s) * pins) + clip_channel_w + clip_channel_off;
back_h = clip_channel_w + clip_channel_off;
front_h = plug_h - back_h;

plug_t = 2; // plug thickness (amount the cutouts should leave around outside of pins & plug)

section_h = (2*pin_r)+pin_s;

teeth_h = pins * section_h;

casing_thickness = 3;
casing_ir = plug_r + tol;
casing_or = casing_ir + casing_thickness;

casing_stack_h = 25;
casing_stack_thickness = 10;
casing_stack_w = pin_r+(tol/2)+casing_stack_thickness;

spring_r = 2;

lid_thickness = 3;
clip_strut_w = 1.3;

module half_cylinder(radius, height) {
	difference() {
		cylinder($fn=200, r=radius, h=height, center=true);
		translate([radius,0,0]) cube([2*radius,2*radius,2*height], center=true);
	}
}

module ring(or, ir, height) {
	difference() {
		cylinder($fn=200, r=or, h=height, center=true);
		cylinder($fn=200, r=ir, h=height+2, center=true);
	}
}

module plug_section(plug_r, pin_r, pin_s, keyway_w, keyway_h, key_channel_w, key_channel_off) {
    difference() {
        cylinder($fn=200,r=plug_r, h=section_h,center=true);
        rotate([90,0,0]) translate([0,0,plug_r/2]) cylinder($fn=200,r=pin_r+tol,h=1.5*plug_r,center=true);
		translate([(plug_r/2)+pin_r-tol,0,0]) cube([plug_r,plug_r,pin_r], center=true);
		translate([-(plug_r/2)-pin_r+tol,0,0]) cube([plug_r,plug_r,pin_r], center=true);
    }
}

module plug_cutouts () {
    difference() {
        cylinder($fn=200, r=plug_r-(clip_channel_d/2)-plug_t, h=plug_h+2, center=true);
        cube([keyway_w + (2*plug_t), 2*plug_r, plug_h+4],center=true);
    }
}

module plug() {
    difference() {
        union() {
            translate([0,0,(pin_r)+(pin_s/2)]) {
                for(i = [0:pins-1]) {
                    translate([0,0,i*section_h]) plug_section(plug_r, pin_r, pin_s, keyway_w, keyway_h, key_channel_w, key_channel_off);
                }
            }
            translate([0,0,0-(clip_channel_w/2)]) cylinder($fn=200,h=clip_channel_w, r=plug_r-(clip_channel_d/2), center=true);
            translate([0,0,0-(clip_channel_w)-(clip_channel_off/2)]) cylinder($fn=200,h=clip_channel_off, r=plug_r, center=true);
        }
        translate([0,0,plug_h/2-back_h]) cube([keyway_w, keyway_h, plug_h+2],center=true);
        translate([0,0,back_h-1]) plug_cutouts();
    }
    translate([0-(keyway_w/2)+(key_channel_w/2),(keyway_w/4)+key_channel_off,plug_h/2-back_h]) cube([key_channel_w, keyway_w/2, plug_h],center=true);
}

module key_blank() {
	difference() {
		translate([0,0,front_h+key_handle_r+0.5]) rotate([0,90,0]) cylinder($fn=200,r=key_handle_r, h=key_thickness, center=true);
		translate([0,0,front_h+(2*key_handle_r)-(2*key_hole_r)]) rotate([0,90,0]) cylinder($fn=200,r=key_hole_r, h=key_thickness+2, center=true);
	}
	difference(){
		union() {
			translate([0,keyway_h/4-tol/2,plug_h/2-pin_s/4]) cube([key_thickness, keyway_h/2-tol, plug_h],center=true);
			translate([0,keyway_h/4-tol/2,-pin_s/4]) rotate([0,90,0]) cylinder($fn=200, h=key_thickness, r=keyway_h/4-tol/2, center=true);
		}
		translate([0-(keyway_w/2)+(key_channel_w/2),(keyway_w/4)+key_channel_off,plug_h/2]) cube([key_channel_w/2+(4*tol),keyway_w/2+(2*tol),1.75*plug_h],center=true);
	}
	translate([0,0,front_h+(key_handle_r/4+pin_s/2)/2+tol]) cube([key_thickness, keyway_h+(2*tol), key_handle_r/4+pin_s/2],center=true);
}

module key_teeth() {
	translate([0,0,-pin_s/4]) rotate([0,-90,0]) linear_extrude(height=key_thickness, center=true, twist=0) polygon(points=[[0,0],[pin_s-pin_r/2,-(bitting[0]*tooth_unit)],[pin_s-pin_r/2,0]]);
	for(i=[1:pins]) {
		translate([0,-((bitting[(i-1)]*tooth_unit)/2),((i-1)*section_h)+(section_h/2)]) cube([key_thickness,bitting[(i-1)]*tooth_unit,2*pin_r],center=true);
		if (i < (pins)) {
			translate([0,0,((i-1)*section_h)+(section_h/2)+pin_s/2]) rotate([0,-90,0]) linear_extrude(height=key_thickness, center=true, twist=0) polygon(points=[[0,0],[0,-bitting[i-1]*tooth_unit],[section_h-(2*pin_r),-bitting[i]*tooth_unit],[section_h-(2*pin_r),0]]);
		}
	}
	translate([0,0,((pins-1)*section_h)+(section_h/2)+pin_s/4+pin_r/2]) rotate([0,-90,0]) linear_extrude(height=key_thickness, center=true, twist=0) polygon(points=[[0,0],[0,-bitting[pins-1]*tooth_unit],[section_h-(3*pin_r)+tol,-tooth_space],[section_h-(3*pin_r)+tol,0]]);
}

module key() {
	key_teeth();
	key_blank();
}

module key_pin(pin_num) {
	translate([0,-(plug_r/2)-(bitting[pin_num]*tooth_unit)/2-pin_r/2,section_h/2]) {
		rotate([90,0,0]) {
			translate([0,0,-(tol/2)]) cylinder($fn=200, r=pin_r, h=plug_r-(bitting[pin_num]*tooth_unit)-(1.5*pin_r)+tol/2,center=true); 
			translate([0,0,-((plug_r-(bitting[pin_num]*tooth_unit)-(pin_r))/2)]) sphere($fn=200,r=pin_r);
		}
	}
}

module key_pins() {
	for (i = [0:pins-1]) {
		translate([0,-tol,(i*section_h)]) key_pin(i);
	}
}	

module driver_pin() {
	translate([0,tol-casing_ir-((casing_thickness+casing_stack_h/2)/2),section_h/2]) rotate([90,0,0]) cylinder($fn=200, r=pin_r, h=casing_thickness+(casing_stack_h/2), center=true);
}

module driver_pins() {
	for (i = [0:pins-1]) {
		translate([0,-(1.5*tol),(i*section_h)]) driver_pin();
	}	
}

module casing_section() {
	translate([0,0,section_h/2]) {
		difference() {
			union() {
				cylinder($fn=200,r=casing_or, h=section_h,center=true);
				translate([0,tol-(casing_stack_h/2)-casing_or+tol,0]) cube([casing_stack_w, casing_stack_h, section_h], center=true);
			}
			cylinder($fn=200,r=casing_ir, h=section_h+2,center=true);
			rotate([90,0,0]) translate([0,0,casing_stack_h]) cylinder($fn=200,r=pin_r+tol,h=casing_stack_h+casing_or+2,center=true);
			
			// Cutouts so you can see the lock working
			translate([(casing_or/2)+pin_r-tol,0,0]) cube([casing_or,(2*casing_or)+(casing_stack_h/2),pin_r-(tol/2)], center=true);
			translate([-(casing_or/2)-pin_r+tol,0,0]) cube([casing_or,(2*casing_or)+(casing_stack_h/2),pin_r-(tol/2)], center=true);
		}
	}
}

module casing_back() {
	// Casing Ring
	translate([0,0,-back_h/2]) ring(casing_or, casing_ir, back_h);
	// Casting Stack
	translate([0,(2*tol)-(casing_stack_h/2)-casing_or,-back_h/2]) cube([pin_r+(tol/2)+casing_stack_thickness, casing_stack_h, back_h+tol/2], center=true);
	// Retaining ring for the plug
	translate([0,0,-(clip_channel_w-(2*tol))/2-tol]) ring(casing_ir+tol, plug_r-tol, clip_channel_w-(2*tol));
}

module casing_blank() {
	for(i = [0:pins-1]) {
		translate([0,0,(i*section_h)]) casing_section();
    }
	casing_back();
}

module casing() {
	difference() {
		casing_blank();
		translate([0,(2*tol)-casing_or-casing_stack_h+clip_channel_d/2,plug_h/2-back_h]) cube([pin_r+(2*tol),clip_channel_d+(3*tol)+clip_channel_off,plug_h+2], center=true);
		translate([0,(2*tol)-casing_or-casing_stack_h+2*tol+clip_channel_d,plug_h/2-back_h]) rotate([0,0,90]) cube([clip_channel_d+(2*tol),clip_channel_w+(2*tol),plug_h+2], center=true);
		translate([-spring_r,(2*tol)-casing_or-casing_stack_h+2*tol+clip_channel_d,-back_h/2]) rotate([90,0,0]) half_cylinder(spring_r+tol,clip_channel_d+(2*tol));
		translate([spring_r,(2*tol)-casing_or-casing_stack_h+2*tol+clip_channel_d,-back_h/2]) rotate([90,0,180]) half_cylinder(spring_r+tol,clip_channel_d+(2*tol));
	}
}

module clip_strut(){
	translate([-spring_r-tol/2,(2*tol)-casing_or-casing_stack_h+2*tol+clip_channel_d,-back_h/2]) rotate([90,5,0]) half_cylinder(spring_r,clip_channel_d);
	translate([spring_r+tol/2,(2*tol)-casing_or-casing_stack_h+2*tol+clip_channel_d,-back_h/2]) rotate([90,5,180]) half_cylinder(spring_r,clip_channel_d);
	translate([-2,(2*tol)-casing_or-casing_stack_h+2*tol+clip_channel_d,-back_h/4]) rotate([0,5,0]) cube([1.4,clip_channel_d,2*back_h+2], center=true);
	translate([2,(2*tol)-casing_or-casing_stack_h+2*tol+clip_channel_d,-back_h/4]) rotate([0,-5,0]) cube([1.4,clip_channel_d,2*back_h+2], center=true);
}

module lid() {
	// Clip Strut
	#clip_strut();
	// Main Lid Section
	translate([0,(2*tol)-casing_or-casing_stack_h+2*tol+clip_channel_d,front_h/2]) cube([clip_channel_w,clip_channel_d,front_h], center=true);
}

translate([-50,0,0]) key();
translate([-40,0,0]) key_pins();
translate([-30,0,0]) driver_pins();
translate([0,0,0]) plug();
translate([50,0,0]) casing();
translate([70,0,0]) lid();