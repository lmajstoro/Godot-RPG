extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 400
const FRICTION = 400

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#Normalize vector to fix movement to botom-right and top-left
	#Equalize speed of right, left, up, down
	input_vector = input_vector.normalized()
	
	#All player action should be multiplied by delta(time between 2 frames)
	#delta is usually 1/60
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	#move_and_slide applies delta on forwarded velocity, no need to do it again
	velocity = move_and_slide(velocity)
