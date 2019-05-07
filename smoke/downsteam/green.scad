// preview[view:front]



/* [Downsteam Settings] */

// min width of the  walls. mm.
min_wall = 2;

// width of strong walls, such as the rim on the female port
rim_wall = 10;

// diameter of the female port
female_open_diameter = 19.5;
// diameter of the final tamper in the female port, usually the internal diameter at 10mm from the opening.
female_hold_diameter = 18;

// size of the plug
male_open_diameter = 29;
// size of the plug, at the tamper
male_enter_diameter = 27.5;

// lenght of the tube, starting from the end of the male plug
tube_lenght = 180;

// height of blubbler component. holes will be this height less min_wall
bubbler_height = 10;
bubbler_diameter = 21;


/* [Hidden] */
w=min_wall;
ww=min_wall*2;

module main_part(){
	// bottom to top
	// we keep track of current z position and the latest top outter diameter, so things
	// can go connecting to one another...

	// 0: bubbler
	z0 = 0;
	bubbler();
	
	// 1: tube
	z1 = bubbler_height;
	o1_top = female_hold_diameter/2;
	translate([ 0, 0, z1] ){
		difference(){
			cylinder(h=tube_lenght-13, r=o1_top);
			translate([0,0,-w])
			cylinder(h=tube_lenght-13+ww, r=o1_top-w);
		}
	}
	// 2: decoration from tube to plug
	// r1 = bottomradius, r2 = top
	z2 = z1 + tube_lenght - 13;
	o2_top = male_enter_diameter/2;
	translate([ 0, 0, z2] ){
		difference(){
			cylinder(h=13, r1=o1_top, r2=o2_top);
			translate([0,0,-w])
			cylinder(h=13+ww, r1=o1_top-w, r2=o2_top-w);
		}
	}
	// 3: male plug
	z3 = z2 + 13;
	o3_top = male_open_diameter/2+w;
	translate([ 0, 0, z3] ){
		difference(){
			cylinder(h=24, r1=o2_top, r2=o3_top);
			translate([0,0,-w])
			cylinder(h=24+ww, r=female_hold_diameter/2);
		}
	}
	// 4: from male plug to relief
	z4 = z3 + 24;
	o4_top = female_hold_diameter/2+w;
	translate([ 0, 0, z4] ){
		difference(){
			cylinder(h=5, r1=o3_top, r2=o4_top);
			translate([0,0,-w])
			cylinder(h=5+ww, r1=female_hold_diameter/2, r2=female_open_diameter/2);
		}
	}
	// 5: relief between male plug and rim of female opening
	z5 = z4 + 5;
	o5_top = o4_top;
	translate([ 0, 0, z5] ){
		difference(){
			cylinder(h=5, r=o5_top);
			translate([0,0,-w])
			cylinder(h=5+ww, r=female_open_diameter/2);
		}
	}
	// 6: from relief to rim
	z6 = z5 + 5;
	o6_top = female_open_diameter/2 + rim_wall; // end on the size of the top rim
	translate([ 0, 0, z6] ){
		difference(){
			cylinder(h=3, r1=o5_top, r2=o6_top);
			translate([0,0,-w])
			cylinder(h=3+ww, r1=o5_top-w, r2=female_open_diameter/2);
		}
	}
	// 7: rim around the female port
	z7 = z6 + 3;
	o7_top = o6_top;
	translate([ 0, 0, z7] ){
		difference(){
			cylinder(h=rim_wall, r=o7_top);
			translate([0,0,-w])
			cylinder(h=rim_wall+ww, r=female_open_diameter/2);
		}
	}
	/* */
}

module bubbler(){
	difference(){
		cylinder(h=bubbler_height, r=bubbler_diameter/2);
		translate([0,0,w])
		cylinder(h=bubbler_height, r=bubbler_diameter/2-w);
		translate([0,0,bubbler_height/2]){
			rotate([90,0,0])
			cylinder(h=bubbler_diameter+ww, r=bubbler_height/2-w, center=true);
			rotate([90,0,45])
			cylinder(h=bubbler_diameter+ww, r=bubbler_height/2-w, center=true);
			rotate([90,0,90])
			cylinder(h=bubbler_diameter+ww, r=bubbler_height/2-w, center=true);
			rotate([90,0,135])
			cylinder(h=bubbler_diameter+ww, r=bubbler_height/2-w, center=true);
		}
	}
}

//rotate( a=180, v=[0,0,1])
color("green", .5)
main_part();

