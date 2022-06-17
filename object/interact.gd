extends Area2D

class_name Interactable

signal interact

func _input_event(viewport, event, shape_idx):
	if not event.is_action_pressed("attack"):
		return
	print("pressed e")
	_interact()

func _interact():
	emit_signal("interact")	
