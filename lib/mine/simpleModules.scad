//modules.scad

module Trapezoid(b1, b2, h) {
  polygon([[-b1/2,0], [b1/2,0], [b2/2,h], [-b2/2,h]]);
}

module line(point1, point2, width = 1, cap_round = true) {
  angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
  offset_x = 0.5 * width * cos(angle);
  offset_y = 0.5 * width * sin(angle);

  offset1 = [-offset_x, offset_y];
  offset2 = [offset_x, -offset_y];

  if(cap_round) {
    translate(point1) circle(d = width, $fn = 24);
    translate(point2) circle(d = width, $fn = 24);
  }

  polygon(points=[
    point1 + offset1, point2 + offset1,  
    point2 + offset2, point1 + offset2
  ]);
}

module polyline(points, width = 1) {
  module polyline_inner(points, index) {
    if(index < len(points)) {
      line(points[index - 1], points[index], width);
      polyline_inner(points, index + 1);
    }
  }

  polyline_inner(points, 1);
}

module heart(x){
  rotate([0,0,45]) {
    square(x);
    translate([x/2,x,0]) circle(d=x);
    translate([x,x/2,0]) circle(d=x);
  }
}

