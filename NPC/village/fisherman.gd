extends CharacterBody2D

const dialog = preload("res://UI/dialog_box.tscn")
@onready var bubble = $Bubble

func _unhandled_input(event):
	if bubble.visible and event.is_action_pressed("ensure"):
		DialogBox.show_dialog_box([
		{text="hello,我是李希沛"},
		{text="hello，你来自哪里"},
		{text="山东菏泽曹县"},
	])



func _on_talk_area_area_entered(area):
	bubble.show()


func _on_talk_area_area_exited(area):
	bubble.hide()
