extends Node2D

@export_file("*.tscn") var target_path = "res://世界/Snow/snow.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_teleporter_body_entered(body):
	get_tree().change_scene(target_path)
