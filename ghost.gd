extends Sprite2D

func _ready() -> void:
	modulate.a = 0.8
	

func _physics_process(delta: float) -> void:
	modulate.a = lerpf(modulate.a, 0, 0.1)
	if modulate.a < 0.05:
		queue_free()
