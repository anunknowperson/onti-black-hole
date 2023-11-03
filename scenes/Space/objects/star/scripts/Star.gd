extends RigidBody3D

@export
var is_good := false

@export
var size := 1.0

static var good_material := preload("res://scenes/Space/objects/star/materials/good_star.material")

static var bad_material := preload("res://scenes/Space/objects/star/materials/bad_star.material")

# Called when the node enters the scene tree for the first time.
func _ready():

	if is_good:
		$Ring.material_override = good_material
	else:
		$Ring.material_override = bad_material
	
	$CollisionShape3D.shape = $CollisionShape3D.shape.duplicate()
	$CollisionShape3D.shape.radius = 0.5 * size
	
	$Ring.mesh = $Ring.mesh.duplicate()
	$Ring.mesh.size = Vector2.ONE * size
	
	$Core.mesh = $Core.mesh.duplicate()
	$Core.mesh.size = Vector2(0.5, 0.6) * size
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


