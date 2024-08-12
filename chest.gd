extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_open = false

func _on_body_entered(body: Node2D) -> void:
	if is_open == false:
		animated_sprite_2d.play("open")
		is_open = true
