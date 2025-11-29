extends CharacterBody2D

@export var speed: float = 100.0 # Higher = faster
@export var jump_force: float = -225.0 # Higher = lower jump

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity") 

# Runs 60 times per second, currently handling movement
func _physics_process(delta: float) -> void:
	
	var direction = Input.get_axis("ui_left", "ui_right") # Checks if you're moving left or right
	velocity.x = direction * speed
	
	# Flips sprite to match your direction
	if direction != 0:
			$AnimatedSprite2D.flip_h = direction < 0
	
	# Jumps if you press the spacebar
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	# Makes you fall when you're in the air
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handles movement
	move_and_slide()	
	
	# Updates animation
	_update_animation()
	
'''
Not on floor = Jump animation

Velocity is greater than 10 = Walk animation

Otherwise play idle animation
'''
func _update_animation():
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif abs(velocity.x) > 10:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("idle")
