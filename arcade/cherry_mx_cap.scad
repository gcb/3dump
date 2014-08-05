$fn=60;

use <../keyboards/cherry/keycap_mount.scad>;
use <cap.scad>;

// thickness of the wall.
wall_thickness = 1;

// diameter of the plunger. ideally in mm
plunger_diameter = 22;
// height of the plunger. ideally in mm
plunger_height = 5;

// concave top? this will only work with diameter==22. ...can't be bothered with math right now.
plunger_concave = false;

// put a cross under the cap for reinforcement. it was done very quick and dirty just so you can add a better one if you need by looking at the code.
plunger_reinforcement = true;


// rotate it upside down for 1) print easier, 2) look better on thingverse screen shot
mirror([0,0,1]) translate([0,0,plunger_height]){
	plunger(d=plunger_diameter, h=plunger_height, concave=plunger_concave);
	mx_mount();
	if( true == plunger_reinforcement ){
		translate([0,0,wall_thickness/2 ]){
			cube([plunger_diameter-wall_thickness,wall_thickness,wall_thickness], center=true);
			rotate([0,0,90])
				cube([plunger_diameter-wall_thickness,wall_thickness,wall_thickness], center=true);
		}
	}
}
