extends Node3D
class_name SolutionWrapper

class Star:
	var position :Vector3
	var radius :float
	
	var type :bool
	
	func _init(p_position, p_radius, p_type):
		self.position = p_position
		self.radius = p_radius
		
		self.type = p_type


var stars_list = null

func get_stars() -> Array:
	if stars_list:
		return stars_list
	
	stars_list = []
	
	var instances = get_parent().instances
	
	for instance in instances:
		var star = Star.new(instance.global_transform.origin, 0.5 * instance.size, instance.is_good)
		
		stars_list.append(star)
	
	return stars_list

var matter_node = null

func get_matter_csg_node() -> CSGBox3D:
	
	if matter_node:
		return matter_node
	
	matter_node = get_parent().get_node( get_parent().matter_node_path )
	
	return matter_node

