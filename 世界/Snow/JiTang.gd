extends Node2D
const dialog = preload("res://UI/dialog_box.tscn")
var playeron_num=0
@onready var aniPlayer=$AnimatedSprite2D
@onready var SnowMap=get_node("../")

signal playeron_once


var isonarea=false

func _ready():
	aniPlayer.set_deferred("visible",false)

func _unhandled_input(event):
	if  aniPlayer.visible==true and event.is_action_pressed("ensure"):
		if playeron_num<=0:
			DialogBox.show_dialog_box([
			{text="在此区域内消灭15只怪物"}])
			emit_signal("playeron_once")
			playeron_num+=1
		else:
			DialogBox.show_dialog_box([
			{text="不是吧，打过了还想打？"},])



func _on_talk_area_body_entered(body):
	aniPlayer.set_deferred("visible",true)
	isonarea=true
	


func _on_talk_area_body_exited(body):
	aniPlayer.set_deferred("visible",false)
	isonarea=false
