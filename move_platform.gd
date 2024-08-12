extends AnimatableBody2D


@onready var rewinder: Rewinder = $Rewinder

var tween: Tween

func _ready() -> void:
	tween = create_tween().set_loops()
	tween.tween_property(self, "position:x", 200, 1).as_relative()
	tween.tween_property(self, "position:x", -200, 1).as_relative()
	

func _process(delta: float) -> void:
	if rewinder.is_rewinding:
		if tween.is_running():
			tween.pause()
	else:
		if not tween.is_running():
			tween.play()
