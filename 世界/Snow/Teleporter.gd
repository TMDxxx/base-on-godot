extends Interactable

class_name Teleporter

@export_file("*.tscn") var target_path = "res://世界/Village/Village.tscn"
# (String, FILE, "*.tscn") 
func _interact():
	super()
	get_tree().change_scene(target_path)
