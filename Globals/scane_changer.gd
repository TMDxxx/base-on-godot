extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $ColorRect/AnimationPlayer

func reload_world(scene):
	animation_player.play_backwards("fade_in")
	print("fade out")
	await animation_player.animation_finished
	get_tree().change_scene(scene)
	animation_player.play("fade_in")
	print("fade in")
	


	
