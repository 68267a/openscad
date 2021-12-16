$fn=200;
; https://youtu.be/gj9H1Ti4yc0
numTicks=4; 1 tick = 1 second
ballWeight=15; grams

; https://jumk.de/math-physics-formulary/rolling.php
; Slope: h = l * sin (a), l>h, 0°<a<90°
; Velocity: v = √ g * h / ( 1/2 + c ) 
; Time: t = 2 * l / v
; h height
; l length
; a angle
; v velocity
; g acceleration 9.81 m/s²
; c shape factor 0.4
; t time

c=0.4
g=9.81
t=1

time = 1; second
speed = distance / time;
distance = sqrt(g*h)/(1/2+c) * time;
time = speed * distance?

// Mass (m)4.3 g
// Gravitational acceleration (g)9.807 m/s²
// Angle (θ)1.948 deg
// Initial velocity (V₀) 0 m/s
// Resulting force (F) 0.0014333 N
// Height (H) 0.3399 cm
// Length (L) 10 cm

// Acceleration (a) 0.2 m/s²
// Rolling time (t) 1 sec
// Final velocity (V) 0.2 m/s

// height	h	h=l*SIN(a)
// length	l	l=h/sin(a)
// angle	a	a=DEGREES(SIN(l/h))
// velocity	v	v=sqrt(g*h)/(1/2+c)
// acceleration	g	9.81
// shape factor	c	0.4
// time	t	t=2*l/v
