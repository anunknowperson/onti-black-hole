@tool
extends CSGBox3D


@export
var node_to_reflect :NodePath

@onready
var original = get_node(node_to_reflect)

var cloned_objects := {}
var original_objects := {}


func compare_nodes(original :Array, clone :Array):
	
	
	var to_create := []
	var to_modify_pairs := []
	var to_destroy := []
	
	for original_node in original:
		
		if original_node not in cloned_objects:
			to_create.append(original_node)
		else:
			to_modify_pairs.append([original_node, cloned_objects[original_node]])
	
	for cloned_node in clone:
		if cloned_node not in original_objects:
			to_destroy.append(cloned_node)
	
	return {"to_create" : to_create, "to_modify_pairs" : to_modify_pairs, "to_destroy" : to_destroy}
	
	
		

func create(list :Array):
	
	for node in list:
		var clone :Node = node.duplicate()
		
		
		add_child(clone)
		clone.set_owner(owner)
		
		cloned_objects[node] = clone
		original_objects[clone] = node

func destroy(list :Array):
	for node in list:
		
		cloned_objects.erase(cloned_objects.find_key(node))
		original_objects.erase(node)
		
		
		node.queue_free()

func modify(list :Array):
	for pair in list:
		var original :Node = pair[0]
		var clone :Node = pair[1]
		
		for p in original.get_property_list ( ):
			
			
			if p["usage"] == PROPERTY_USAGE_DEFAULT :
				if clone.get(p["name"]) != original.get(p["name"]):
					print(p["name"])
					clone.set(p["name"], original.get(p["name"]))
			
			if "global_transform" in original:
				if clone.global_transform != original.global_transform:
					clone.global_transform = original.global_transform
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var lists = compare_nodes(original.get_children(), get_children())
	
	var to_create = lists["to_create"]
	var to_modify_pairs = lists["to_modify_pairs"]
	var to_destroy = lists["to_destroy"]
	
	create(to_create)
	
	modify(to_modify_pairs)
	
	destroy(to_destroy)
