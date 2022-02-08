extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 10
const FRICTION = 10

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

		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
		print(velocity)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	

	self.move_and_collide(velocity)
