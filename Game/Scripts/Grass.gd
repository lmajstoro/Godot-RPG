extends Node2D

const GDE_SCENE = "res://Scenes/GrassDestroyEffect.tscn"

func _grassBehaviour():
	#Load and create instance of scene (destroy animation)
	var GrassDestroyEffect = load(GDE_SCENE)
	var grassDestroyEffect = GrassDestroyEffect.instance()
	#fetch main sceen (World)
	var world = get_tree().current_scene
	#attach destroy animation as child to main scene
	var ySort = world.get_node("WorldYSort")
	ySort.add_child(grassDestroyEffect)
	#position destroy animation on grass position
	grassDestroyEffect.position = self.position
	#destroy static grass
	
func _on_Hurtbox_area_entered(area):
	_grassBehaviour()
	queue_free()
	pass # Replace with function body.
