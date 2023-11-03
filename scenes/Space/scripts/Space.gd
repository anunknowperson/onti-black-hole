extends Node3D

@export
var matter_node_path :NodePath

@export
var star : PackedScene

var instances := []

var score := 0


func _spawn_stars():
	var file := FileAccess.open("input.txt", FileAccess.READ)
	
	var count = int(file.get_line())
	
	for i in range(count):
			var star_position :Vector3
			var star_size :float
			var star_type :bool
			
			var stararr := file.get_line().split(" ")
			
			star_position = Vector3(float(stararr[0]), float(stararr[1]), float(stararr[2]))
			
			star_size = float(stararr[3])
			
			star_type = bool(int(stararr[4]))
			
			
			var instance = star.instantiate()
			
			instance.size = star_size

			instance.is_good = star_type
			
			add_child(instance)
			
			instance.global_position = star_position
			
			
			
			instances.append(instance)

	

func _enter_tree():
	_spawn_stars()

func _process(delta):
	pass

func _ready():
	
	await get_tree().create_timer(10).timeout
	
	var file := FileAccess.open("output.txt",FileAccess.WRITE)
	
	file.store_string(str(score))
	
	file.close()
	
	get_tree().quit()

func _on_area_3d_body_entered(body):
	if not body.is_in_group("star"):
		return
	
	if body.is_good:
		score += 1
	else:
		score -= 1
	
	$Label.text = "Score: %d" % score
