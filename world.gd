extends Node2D
const Beastmaster = preload("res://NPC/Beastmaster/beastmaster_status.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var beastmaster = Beastmaster.instantiate()
	var main = get_tree().current_scene
	main.add_child(beastmaster)
