@tool
class_name ObtainEditorCamera
extends EditorPlugin

static var camera :Camera3D

func _enter_tree():
	pass

func _handles(object):
	return true

func _edit(object):
	pass

func _make_visible(visible):
	pass

func _forward_3d_gui_input(viewport_camera, event):
	camera = viewport_camera

func _exit_tree():
	pass
