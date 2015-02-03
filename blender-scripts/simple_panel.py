# <pep8 compliant>
#vim :set ts=4 sw=4 sts=4 et smarttab :
import bpy
from bpy.types import Menu, Panel
from bl_ui.properties_paint_common import UnifiedPaintPanel


class View3DPanel2():
    bl_space_type = 'VIEW_3D'
    bl_region_type = 'TOOLS'



# ********** default tools for object-mode ****************

class ScadPanel(View3DPanel2, Panel):
    bl_context = "objectmode"
    bl_label = "openSCAD"

    def draw(self, context):
        layout = self.layout
        row1 = layout.row()
        row1.label(text="Import:")
        
        row2 = layout.row()
        row2.operator("mesh.primitive_plane_add")
        
        #col = layout.column(align=True)
        #col.label(text="Import:")
        #col.operator("scad.import.file", text="from file")

        #col = layout.column(align=True)
        #col.operator("scad.import.origin_set", text="Origin")


        #active_object = context.active_object
        #if active_object and active_object.type in {'MESH', 'CURVE', 'SURFACE'}:


def register():
    bpy.utils.register_class(ScadPanel)


def unregister():
    bpy.utils.unregister_class(ScadPanel)







# ****************** operator

class YourOperator(bpy.types.Operator):
    '''docstring'''
    __idname__ = "scad.test" # like "myops.myop"
    __label__ = "The string you see ie. in command search (ctrl+space)" 
    # like "My Operator"
    __props__ = [] # list of props used, see release/io/export_ply.py for example
    def poll(self, context):
        # checks to ensure your operator has what it needs
        return True # or False if context is not correct, ie no selected objects
    def execute(self, context):
        # your main part of the script should come in execute
        bpy.ops.mesh.primitive_plane_add()
        return ('FINISHED', ) # or 'CANCELLED' or any of the others, depending on what you need. 

# add operator






# **************** main

if __name__ == "__main__":
    bpy.ops.add(YourOperator)
    register()

