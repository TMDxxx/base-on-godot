extends Node2D

@export_file("*.tscn") var target_path = "res://世界/Village/villageleft.tscn"
const Beastmaster = preload("res://NPC/Beastmaster/Beastmaster.tscn")


var transfer = false
var dir
func _ready():
	var beastmaster = Beastmaster.instantiate()
	beastmaster.position = Vector2(20,150)
	add_child(beastmaster)

func _process(delta):
	if Input.is_action_pressed("ensure") and transfer == true:
		GlobalData.change_num(dir)
		ScaneChanger.reload_world(target_path)

func _on_teleporter_body_entered(body):
	print("in")
	transfer = true
	dir = 1


func _on_teleporter_body_exited(body):
	print("out")
	transfer = false
