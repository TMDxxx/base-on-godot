extends CharacterBody2D

const dialog = preload("res://UI/dialog_box.tscn")
@onready var bubble = $Bubble
@onready var animation_tree = $AnimationTree
@onready var animationState = animation_tree.get("parameters/playback")

func _ready():
	velocity = Vector2.RIGHT
	animation_tree.set("parameters/IDLE/blend_position",velocity)
	animation_tree.set("parameters/WALK/blend_position",velocity)
	animationState.travel("IDLE")

func _unhandled_input(event):
	if bubble.visible and event.is_action_pressed("ensure"):
		DialogBox.show_dialog_box([
		{text="红头发：你进来的旁边就是我家。"},
		{text="红头发：下面不知道闹什么鬼，一直有源源不断的史莱姆出现。。"},
		{text="红头发：西边的桥边有个小孩子一直堵着桥，说一些奇怪的话，，，"},
		{text="红头发：他好像要钱来着，但是作者还没有实现打怪爆金币啊！"},
		{text="红头发：不过你可以从下方史莱姆地方穿过去，上面也有一座隐形的桥，不知道怎么样才能看见"},
	])



func _on_talk_area_area_entered(area):
	bubble.show()


func _on_talk_area_area_exited(area):
	bubble.hide()
