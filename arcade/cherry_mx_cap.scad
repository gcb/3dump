$fn=60;

use <../keyboards/cherry/keycap_mount.scad>;

// thickness of the wall.
wall_thickness = 1;

// diameter of the plunger. ideally in mm
plunger_diameter = 22;
// height of the plunger. ideally in mm
plunger_height = 5;
// put a cross under the cap for reinforcement. it was done very quick and dirty just so you can add a better one if you need by looking at the code.
plunger_reinforcement = true;

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
	translate([0,0,-wall_thickness])
	difference(){
		union(){
			difference(){
				torus( r=d/10, d=d );
				translate([0,0,d/2])
					cube( [d,d,d], center=true );
			}
			translate([0,0,-d/10])
				cylinder( h=d/10, r=d/2 - d/10, center=false);
			cylinder( h=h-(d/10), r=d/2 , center=false);
		}
		translate([0,0,wall_thickness])
			cylinder( h=h-(d/10), r=d/2-1 , center=false);
	}
}

// rotate it upside down for 1) print easier, 2) look better on thingverse screen shot
mirror([0,0,1]) translate([0,0,plunger_height]){
	plunger(d=plunger_diameter, h=plunger_height, convex=true);
	mx_mount();
	if( true == plunger_reinforcement ){
		translate([0,0,wall_thickness/2 ]){
			cube([plunger_diameter-wall_thickness,wall_thickness,wall_thickness], center=true);
			rotate([0,0,90])
				cube([plunger_diameter-wall_thickness,wall_thickness,wall_thickness], center=true);
		}
	}
}
