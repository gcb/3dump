#!BPY
"""
Name: 'Import openSCAD'
Blender: 236
Group: 'Object'
Tooltip: 'this will import HOME/import.scad'
"""
# above is newer blender info snipet
# bellow is older blender. remove when debian moves to new blender versions.
bl_info = {
    "name": "Import openSCAD",
    "author": "gcb",
    "version": (0, 1),
    "blender": (2, 36, 0),
    "location": "View3D > Add > openSCAD",
    "description": "Imports openSCAD from HOME/import.scad",
    "warning": "",
    "tracker_url": "",
    "category": "Add Mesh"
}

try:
	import Blender
	Blender_available = True
except ImportError:
	# damn debian and its ancient versions of non essential software
	import bpy
	Blender_available = False
import ply

def add_to_scene(obj):
	if not Blender_available:
		return
	TheScene = Blender.Scene.GetCurrent()
	TheScene.link(obj)
	TheScene.update()
	Blender.Window.Redraw()
	return
def read_file(fname):
	#f = open(fname, 'r')
	#return f.read();
	#TODO: for now just return "xxx"
	return "cube(size = 1, center = false);\ncube(size = [1,2,3], center = true);"
def b_cube(size=[1,1,1], center=[0,0,0]):
	#NOTE: first issue, cubes in blender are proper cubes. need to scale to change size, aparently
	#      or at least only on the bpy interface
	if not Blender_available :
		obj = bpy.ops.mesh.primitive_cube_add(view_align=False, enter_editmode=False, location=center, rotation=(0, 0, 0), layers=(True, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False))
	else :
		obj = Blender.Object.New('Cube')
		obj.locX = center[0]
		obj.locY = center[1]
		obj.locZ = center[2]
	return obj

def parse_openSCAD_script(txt):
	#for now just return a cube
	return b_cube()

	


# lazy prototype stage... TODO: show file diaload somehow
#continue = Blender.Draw.PupMenu("Import openSCAD%t|Load home importscad|cancel")
#if continue == 1 :
txt = read_file('~/import.scad')
obj = parse_openSCAD_script(txt)
add_to_scene(obj)
#endif continue is 1
