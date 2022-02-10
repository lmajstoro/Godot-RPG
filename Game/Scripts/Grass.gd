extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		#Load and create instance of scene (destroy animation)
		var GrassDestroyEffect = load("res://Scenes/GrassDestroyEffect.tscn")
		var grassDestroyEffect = GrassDestroyEffect.instance()
		#fetch main sceen (World)
		var world = get_tree().current_scene
		#attach destroy animation as child to main scene
		world.add_child(grassDestroyEffect)
		#position destroy animation on grass position
		grassDestroyEffect.position = self.position
		#destroy static grass
		queue_free()
		
		

