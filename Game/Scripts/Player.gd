extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 400
const FRICTION = 400
const IDLE_BLEND = "parameters/Idle/blend_position"
const MOVEMENT_BLEND = "parameters/Movement/blend_position"
const ATTACK_BLEND = "parameters/Attack/blend_position"
const SPECIAL_ATTACK_BLEND = "parameters/SpecialAttack/blend_position"
const PLAYBACK = "parameters/playback"

enum {
	MOVE,
	ROLL,
	ATTACK,
	SPECIAL_ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO


onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get(PLAYBACK)

func _ready():
	var hitbox = self.get_node("HitboxPivot/SwordHitbox/CollisionShape2D")
	hitbox.disabled = true
	animationTree.active = true

#execute one state at the time
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state()
		SPECIAL_ATTACK:
			special_attack_state()
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		get_animation_trees(input_vector)
		animationState.travel("Movement")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("specialAttack"):
		state = SPECIAL_ATTACK
	
func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func special_attack_state():
	velocity = Vector2.ZERO
	animationState.travel("SpecialAttack")
	
#method added to end of animation (mehtod track)
func attack_animation_finished():
	state = MOVE

func get_animation_trees(input_vector):
	animationTree.set(IDLE_BLEND, input_vector)
	animationTree.set(MOVEMENT_BLEND, input_vector)
	animationTree.set(ATTACK_BLEND, input_vector)
	animationTree.set(SPECIAL_ATTACK_BLEND, input_vector)

