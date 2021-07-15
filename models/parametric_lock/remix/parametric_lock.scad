$fn=200;

bitting = [3,4,8,3,7];

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
plug_t = 2; // plug thickness (amount the cutouts should leave around outside of pins & plug)
plug_h = (((2*pin_r)+pin_s) * pins) + clip_channel_w + clip_channel_off;
back_h = clip_channel_w + clip_channel_off;
front_h = plug_h - back_h;
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

