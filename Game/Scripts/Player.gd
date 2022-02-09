extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 400
const FRICTION = 400
const IDLE_BLEND = "parameters/Idle/blend_position"
const MOVEMENT_BLEND = "parameters/Movement/blend_position"
const PLAYBACK = "parameters/playback"

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get(PLAYBACK)

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animationTree.set(IDLE_BLEND, input_vector)
		animationTree.set(MOVEMENT_BLEND, input_vector)
		animationState.travel("Movement")
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
