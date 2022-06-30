extends Node2D
const dialog = preload("res://UI/dialog_box.tscn")
@onready var aniPlayer=$AnimatedSprite2D
var isonarea=false

func _ready():
	aniPlayer.set_deferred("visible",false)

func _unhandled_input(event):
	if  aniPlayer.visible==true and event.is_action_pressed("ensure"):
		DialogBox.show_dialog_box([
		{text="在此区域内消灭15只怪物"},
		{text="hello，你来自哪里"},
		{text="山东菏泽曹县"},
	])
	
	



func _on_talk_area_body_entered(body):
	aniPlayer.set_deferred("visible",true)
	isonarea=true
	


func _on_talk_area_body_exited(body):
	aniPlayer.set_deferred("visible",false)
	isonarea=false
