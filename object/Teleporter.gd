extends Interactable


@export_file("*.tscn") var target_path = "res://世界/Snow/snow.tscn"
# (String, FILE, "*.tscn") 
func _interact():
	super()
	get_tree().change_scene(target_path)
