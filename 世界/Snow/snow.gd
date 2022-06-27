extends Node2D

const Beastmaster = preload("res://NPC/Beastmaster/Beastmaster.tscn")
@export_file("*.tscn") var target_path = "res://世界/Snow/snow.tscn"

func _ready():
	var beastmaster = Beastmaster.instantiate()
	beastmaster.position = Vector2(20,150)
	add_child(beastmaster)


func _on_teleporter_body_entered(body):
	ScaneChanger.reload_world(target_path)
