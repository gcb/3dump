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


module p1(dlarge, dsmall, droller){
	difference(){
		union(){
			translate([0,0,-wall_thickness]) color("green")  // large
				cylinder( h=wall_thickness*3, r=dlarge/2, center=false);
			translate([dsmall,0,-wall_thickness]) color("green")  // small
				cylinder( h=wall_thickness*3, r=dsmall/2, center=false);
			difference(){
				translate([0,0,-wall_thickness]) color("green")  // shaft
					cylinder( h=10.7, r=droller/2, center=false);
				union(){  // 7.5
					translate([-10,7.5/2,0]) color("lightgreen")  // sides
						cube([20,10,20]);
					translate([-10,-7.5/2-10,0]) color("lightgreen")  // sides
						cube([20,10,20]);
				}
			}
			translate([0,0,-wall_thickness-.6]) color("darkgreen") // lower rim
				cylinder( h=wall_thickness*3+1.2, r=12.46/2, center=false);
			translate([0,0,9.7]) color("darkgreen") // upper rim
				cylinder( h=.6, r=12.46/2, center=false);
		}
		union(){
			translate([0,0,-30]) color("green") // shaft hole
				cylinder( h=100, r=4.7/2, center=false);
			translate([dlarge/2,0,-wall_thickness*2]) color("lightgreen")  // small cut out
				cylinder( h=wall_thickness*2, r=dsmall/2-wall_thickness, center=false);
		}
	}
}
p1(24,12,9);
