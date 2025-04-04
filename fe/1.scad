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


/* @param dlarge diameter of larger circle.
 * @param dsmall of smaller circle.
 * @param droller diameter of pin roller.
 * @param hroller height of pin roller.
 * @param dgap   size of the parallel side.s on pin roller.
*/
module p1(dlarge, dsmall, droller, hroller, dgap){
	difference(){
	//union(){
		//translate([-12,-5,-10]) cube([32,10,10]); // length measurement
		union(){
			translate([0,0,-wall_thickness]) color("green")  // large
				cylinder( h=wall_thickness*3, r=dlarge/2, center=false);
			translate([dlarge/2+wall_thickness,0,-wall_thickness]) color("green")  // small
				cylinder( h=wall_thickness*3, r=dsmall/2, center=false);
			// bulges
			translate([dlarge/2-dsmall/4,dsmall/2.5,-wall_thickness]) color("green")
				cylinder( h=wall_thickness*3, r=dsmall/4, center=false);
			translate([dlarge/2,dsmall/3.5,-wall_thickness]) color("green")
				cylinder( h=wall_thickness*3, r=dsmall/4, center=false);
			translate([dlarge/2-dsmall/4,-dsmall/2.5,-wall_thickness]) color("green")
				cylinder( h=wall_thickness*3, r=dsmall/4, center=false);
			translate([dlarge/2,-dsmall/3.5,-wall_thickness]) color("green")
				cylinder( h=wall_thickness*3, r=dsmall/4, center=false);

			difference(){ // center roller pin
				translate([0,0,-wall_thickness]) color("green")  // shaft
					cylinder( h=hroller, r=droller/2, center=false);
				union(){  // pin roller side cuts
					translate([-dlarge/2,dgap/2,0]) color("lightgreen")  // sides
						cube([dlarge,dlarge/2,dlarge]);
					translate([-dlarge/2,-dgap/2-dlarge/2,0]) color("lightgreen")  // sides
						cube([dlarge,dlarge/2,dlarge]);
				}
			}
			translate([0,0,-wall_thickness*2]) color("darkgreen") // lower rim
				cylinder( h=wall_thickness, r=5, center=false);
			translate([0,0,wall_thickness*2]) color("darkgreen") // upper
				cylinder( h=wall_thickness, r=6, center=false);
			translate([0,0,hroller-wall_thickness]) color("darkgreen") // top rim
				cylinder( h=wall_thickness, r=6, center=false);

			csize = droller/4; // sides of the little squares
			translate([dlarge/2+dsmall/2-csize/2, -csize/2, wall_thickness*2]) color("green")
				littlesquares(csize, wall_thickness, .9);
			translate([-dlarge/2, -csize/2, wall_thickness*2]) color("green")
				littlesquares(csize, wall_thickness, .9);

		}
		union(){
			translate([0,0,-30]) color("lightgreen") // shaft hole
				cylinder( h=100, r=4.7/2, center=false);
			translate([dlarge/2 + wall_thickness,0,-wall_thickness*2]) color("lightgreen")  // small cut out
				cylinder( h=wall_thickness*2, r=dsmall/2-wall_thickness, center=false);

			// cog theeth
			translate([0,0,0]) color("lightgreen")
				notches( dlarge/2 - wall_thickness*1.4, wall_thickness*2, wall_thickness*5,
					[-40:12:30]
				);
		}
	}
}
p1(26,13, 9, 10.7, 7.5);

module littlesquares(csize, wall_thickness, dhole){
	difference(){
		side2trapezoid(csize, wall_thickness, 6);
		translate([csize/2, csize/2, -wall_thickness])
			cylinder( h=wall_thickness*3, r=dhole/2, center=false );
	}
}

/* create prism on the edge of a circle
 * @param angles the same param used to a rotation for loop
 */
module notches(r, depth, h, angles){
	union(){
		for( i = angles)
				chamfer(i, r, depth, depth, h);
		mirror([0,1,0]) union(){
			for( i = angles)
				chamfer(i, r, depth, depth, h);
		}
	}
}
module chamfer(angle, r, l, width, height){
		rotate([0,0,angle])
		translate([0,r, -width])
						prismfront(l,width,height);
}

module prismfront(l, w, h){
		polyhedron(//pt 0   1          2          3        4        5
			points=[[0,0,0], [w/2,l,0], [-w/2,l,0], [0,0,h], [w/2,l,h], [-w/2,l,h]],
			faces=[
			[0,1,2] // bottom
			,[3,5,4] //top
			,[1,4,5,2] // back
			,[0,2,5,3] // left
			,[0,3,4,1] // right
			]
		);
}
module prism(l, w, h){
		polyhedron(//pt 0   1        2          3        4        5
			points=[[0,0,0], [w,0,0], [w/2,l,0], [w,0,h], [0,0,h], [w/2,l,h]],
			faces=[
			[0,1,2] // bottom
			,[3,4,5] //top
			,[0,1,3,4] // back
			,[1,2,5,3] // left
			,[0,2,5,4] // right
			]
		);
}


/* a square on the bottom, with a square-square/tamper on the top */
module trapezoid(s, h, tamper){
	offset = s / tamper;
	polyhedron(
		points = [
			[  0,  0,  0 ],  //0
			[  s,  0,  0 ],  //1
			[  s,  s,  0 ],  //2
			[  0,  s,  0 ],  //3
			[  0+offset,  0+offset,  h ],  //4
			[ s-offset,   0+offset,  h ],  //5
			[ s-offset,   s-offset,  h ],  //6
			[ 0+offset,   s-offset,  h ]], //7
		faces = [
			[0,1,2,3],  // bottom
			[4,5,1,0],  // front
			[7,6,5,4],  // top
			[5,6,2,1],  // right
			[6,7,3,2],  // back
			[7,4,0,3]   // left
		]
	);
}
/* a parallelepiped with bevel on the sides */
module sidetrapezoid(s, h, tamper){
	offset = s / tamper;
	polyhedron(
		points = [
			[  0,  0,  0 ],  //0
			[  s,  0,  0 ],  //1
			[  s,  s,  0 ],  //2
			[  0,  s,  0 ],  //3
			[  0+offset,  0,  h ],  //4
			[ s-offset,   0,  h ],  //5
			[ s-offset,   s,  h ],  //6
			[ 0+offset,   s,  h ]], //7
		faces = [
			[0,1,2,3],  // bottom
			[4,5,1,0],  // front
			[7,6,5,4],  // top
			[5,6,2,1],  // right
			[6,7,3,2],  // back
			[7,4,0,3]   // left
		]
	);
}
/* same as above but other sides, avoid one rotation */
module side2trapezoid(s, h, tamper){
	offset = s / tamper;
	polyhedron(
		points = [
			[  0,  0,  0 ],  //0
			[  s,  0,  0 ],  //1
			[  s,  s,  0 ],  //2
			[  0,  s,  0 ],  //3
			[  0,  0+offset,  h ],  //4
			[ s,   0+offset,  h ],  //5
			[ s,   s-offset,  h ],  //6
			[ 0,   s-offset,  h ]], //7
		faces = [
			[0,1,2,3],  // bottom
			[4,5,1,0],  // front
			[7,6,5,4],  // top
			[5,6,2,1],  // right
			[6,7,3,2],  // back
			[7,4,0,3]   // left
		]
	);
}

/* todo: trapezoid() that takes width and length for the base object */
