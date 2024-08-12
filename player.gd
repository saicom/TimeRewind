extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim: AnimatedSprite2D = $Anim
@onready var rewinder: Rewinder = $Rewinder

func custom_data():
	var texture = anim.sprite_frames.get_frame_texture(anim.animation, anim.frame)
	return {
		"texture": texture,
		"animation": anim.animation,
		"flip_h": anim.flip_h
	}
	
func apply_data(data):
	anim.animation = data.animation
	anim.flip_h = data.flip_h


func _physics_process(delta: float) -> void:
	if rewinder.is_rewinding:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")
		
	if velocity.y < 0:
		anim.play("jump")
	elif velocity.y > 0:
		anim.play("fall")
		
	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false

	move_and_slide()
