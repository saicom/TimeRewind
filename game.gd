extends Node2D
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("rewind"):
		color_rect.show()
	else:
		color_rect.hide()
