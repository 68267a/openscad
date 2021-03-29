// Credit to OpenSCAD IRC for the Trapezoid module and the pow() suggestion. Thanks!
// Line and Polyline modules from here: https://openhome.cc/eGossip/OpenSCAD/Polyline.html

tW = 60;			  								//topperWidth (result is actually ~25% smaller)

///////////////////////////////////////////////
// Do not modify anything below this line.
// I think this is how parametric design works?
///////////////////////////////////////////////

$fn = 200;											//circle smoothness
tWh = tW/2;											//topperWidthHalf
tWhD = sqrt(2*pow(tWh,2));		  //topperWidthHalfDiagonal (a^2+b^2=c^2) //not used
bW = tW*.60;										//bodyWidth
bL = tW*1.25; 									//bodyLength
cW = bW*.3;                     //cutoutWidth
cL = bL;                        //cutoutLength

///////////////////////////////////////////////
// I mean, I guess you could if you wanted to.
///////////////////////////////////////////////

// supporting modules
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

module heart(){
  rotate([0,0,45]) {
    square(tWh);
    translate([tWh/2,tWh,0]) circle(d=tWh);
    translate([tWh,tWh/2,0]) circle(d=tWh);
  }
}

// end supporting modules

module topper(){
  //the shape at the top. 
  
  heart();
  //Trapezoid(tWhD,tWhD,tWhD);
  //circle(d=tW);
  //polygon([[-bW,0],[bW,0],[bW,tW],[-bW,tW]]);
}

module body(){
  translate([0,-bL,0]) Trapezoid(bW,bW,bL); 
  Trapezoid(bW,cW,bW); 
  translate([0,-bL,0]) rotate([0,0,180]) Trapezoid(bW,bW*.66,bW*.33); 
  
}

module cutoutShape() {
  polyline(
    [
      [-bW*.3,  bW/1.5 ], 
      [-bW*.2,  bW/2   ],
      [-bW*.3,  1      ],
      [-bW*.3, -bL*.9  ],
      
      [-bW*.15, -bL     ],
      [ bW*.15, -bL     ],
      
      [ bW*.3, -bL*.9  ],
      [ bW*.3,  0      ],
      [ bW*.2,  bW/2,0 ],
      [ bW*.3,  bW/1.5 ]
    ],2
  );
}

module pageSlider(){
  // not implemented. 
  // The idea is that when you place the body, you know which page 
  // you were on, but you might not remember where you were on that page. 
  // I was planning on putting a slider or clip of some sort.

  circle(15);
}

module bookmark(cutout, slider){
  if (cutout) {
    difference() {
      union() {
        topper(); 
        body();
      }
      cutoutShape();
    }
  } else {
    topper();
    body();
  }
  if (slider) #pageSlider();
}

linear_extrude(1)
  bookmark(cutout=true, slider=false);

linear_extrude(1)
  translate([tW,0,0]) 
    bookmark();