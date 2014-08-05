$fn=60;

// thickness of the wall.
wall_thickness = 1;

// diameter of the plunger
plunger_diameter = 22;
// height of the plunger
plunger_height = 5;

// concave top? this will only work with diameter==22. ...can't be bothered with math right now.
plunger_concave =false;


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

module plunger(d, h, concave){
	translate([0,0,-wall_thickness])
	difference(){
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
		if( true == concave ){
			if( 22 == plunger_diameter ){
				// trial and error concave. TODO: recall basic trigonometry...
				translate([0,0,-d*2-1.3])
					sphere( r=d*2);
			}
		}
	}
}

difference(){
	plunger(d=plunger_diameter, h=plunger_height, concave=true);
	translate([0,0,-plunger_diameter/2])
	cube([plunger_diameter,plunger_diameter,plunger_diameter]);
}
