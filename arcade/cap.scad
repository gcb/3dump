$fn=60;


wall_thickness = 1; // thickness of the wall.

/* values from happ:
(i assume their values are inches, since there is no unit...)
ext bezel diam = 1.3in (33mm)
bezel height = no idea. i will guess 0.14in (3.5mm)
plunger diam = 0.87in (22mm)
plunger height out of bezel = 0.14in (3.5mm)
plunger travel = no idea.
threaded body diam = 1.10in (27.95mm)

mounting hole diameter = 1.13in (28.7mm)
*/

module torus(r, d){
	rotate_extrude(convexity = 10)
		translate([d/2-r, 0, 0])
			circle(r=r);
}

module plunger(d, h, convex){
		difference(){
			translate([0,0,h/2])
			union(){
				cylinder( h=h, r=d/2, center=true);
				translate([0,0,h/2])
					torus( r=d/10, d=d );
				translate([0,0,h/2])
					cylinder( h=d/5, r=d/2 - d/10, center=true);
			}
			translate([0,0,-wall_thickness])
				cylinder( h=(h/2)+wall_thickness, r=d/2-wall_thickness, center=false);
		}
}

plunger(d=22, h=5, convex=true);


