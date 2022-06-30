extends CharacterBody2D

const dialog = preload("res://UI/dialog_box.tscn")
@onready var bubble = $Bubble
@onready var animation_tree = $AnimationTree
@onready var animationState = animation_tree.get("parameters/playback")

func _ready():
	velocity = Vector2.DOWN
	animation_tree.set("parameters/IDLE/blend_position",velocity)
	animation_tree.set("parameters/WALK/blend_position",velocity)
	animationState.travel("IDLE")

func _unhandled_input(event):
	if bubble.visible and event.is_action_pressed("ensure"):
		DialogBox.show_dialog_box([
		{text="hello"},
		{text="hello，你来自哪里"},
		{text="山东菏泽曹县"},
	])



func _on_talk_area_area_entered(area):
	bubble.show()


func _on_talk_area_area_exited(area):
	bubble.hide()
