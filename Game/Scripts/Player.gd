extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 400
const FRICTION = 400

var velocity = Vector2.ZERO

#onready var creates once node is loaded
#with $ you access child nodes
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		#todo fix with animation tree
		if input_vector.x > 0:
			animationPlayer.play("run_right")
		else:
			animationPlayer.play("run_left")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationPlayer.play("idle_right")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
