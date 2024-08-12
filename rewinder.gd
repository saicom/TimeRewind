extends Node
class_name Rewinder

var parent: Node2D
var is_rewinding = false
var uid: int
const GHOST = preload("res://ghost.tscn")

func _ready() -> void:
	parent = get_parent()
	RewindMgr.add_rewinder(self)
	
func data():
	is_rewinding = false
	var base_data = {
		"scale": parent.scale,
		"global_position": parent.global_position
	}
	var custom_data = {}
	if parent.has_method("custom_data"):
		custom_data = parent.custom_data()
	base_data.merge(custom_data)
	
	return base_data

func rewind(_data):
	is_rewinding = true
	parent.scale = _data.scale
	parent.global_position = _data.global_position
	if parent.has_method("apply_data"):
		parent.apply_data(_data)
	add_ghost(_data)
	
func add_ghost(_data):
	if "texture" not in _data:
		return
		
	var ghost: Sprite2D = GHOST.instantiate()
	ghost.texture = _data.texture
	ghost.scale = _data.scale
	ghost.flip_h = _data.flip_h
	ghost.global_position = _data.global_position
	ghost.z_index = -1
	
	get_tree().root.add_child(ghost)
