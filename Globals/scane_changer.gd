extends CanvasLayer

@onready var color_rect = $ColorRect

func change_scene(path:String):
	var tween := create_tween()
	tween.tween_callback(color_rect.color.red).set_delay(2)
