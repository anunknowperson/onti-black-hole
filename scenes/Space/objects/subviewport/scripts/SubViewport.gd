@tool
extends SubViewport

@export
var camera_path :NodePath

@onready
var camera := get_node(camera_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var real_camera = null
	var real_viewport = null
	
	if Engine.is_editor_hint():
		real_camera = ObtainEditorCamera.camera
		
	else:
		real_camera = camera
	
	if real_camera:
		$Camera3D.global_transform = real_camera.global_transform
		$Camera3D.fov = real_camera.fov
		
		size = real_camera.get_viewport().size
