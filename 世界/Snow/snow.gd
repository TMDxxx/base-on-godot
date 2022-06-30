extends Node2D

const Beastmaster = preload("res://NPC/Beastmaster/Beastmaster.tscn")
@export_file("*.tscn") var target_path = "res://世界/Village/Village.tscn"
var player = Beastmaster.instantiate()
func _ready():
	#var beastmaster = Beastmaster.instantiate()
	player.position = Vector2(441,44)
	add_child(player)


func _on_teleporter_body_entered(body):
	ScaneChanger.reload_world(target_path)
