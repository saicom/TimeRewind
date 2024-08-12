extends Node

var all_rewinders: Dictionary = {}
var cur_uid: int = 0
var all_data: Dictionary = {}

const limit_size: int = 60 * 60

func record():
	for id in all_rewinders:
		var obj = all_rewinders[id] as Rewinder
		var data_list = []
		if id in all_data:
			data_list = all_data[id]
		data_list.push_front(obj.data())
		if data_list.size() > limit_size:
			data_list.pop_back()
		all_data[id] = data_list
		

func rewind():
	for id in all_rewinders:
		var obj: Rewinder = all_rewinders[id]
		if id not in all_data:
			continue
		var data_list: Array = all_data[id]
		if data_list.size() < 1:
			continue
		var data = data_list.pop_front()
		obj.rewind(data)

func uid():
	cur_uid += 1
	return cur_uid
	
func add_rewinder(obj: Rewinder):
	obj.uid = uid()
	all_rewinders[obj.uid] = obj	
	

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("rewind"):
		rewind()
	else:
		record()
	
