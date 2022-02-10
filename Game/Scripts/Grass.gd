extends Node2D

const GDE_SCENE = "res://Scenes/GrassDestroyEffect.tscn"

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		_grassBehaviour()
	elif Input.is_action_just_pressed("specialAttack"):
		_grassBehaviour()
		
func _grassBehaviour():
	#Load and create instance of scene (destroy animation)
	var GrassDestroyEffect = load(GDE_SCENE)
	var grassDestroyEffect = GrassDestroyEffect.instance()
	#fetch main sceen (World)
	var world = get_tree().current_scene
	#attach destroy animation as child to main scene
	world.add_child(grassDestroyEffect)
	#position destroy animation on grass position
	grassDestroyEffect.position = self.position
	#destroy static grass
	queue_free()
