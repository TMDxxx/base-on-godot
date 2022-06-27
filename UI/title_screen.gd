extends Control

const target_path = "res://世界/Village/Village.tscn"
const Beastmaster = preload("res://NPC/Beastmaster/Beastmaster.tscn")

@onready var click_sound = $ClickSound
@onready var animation_player = $UI/Control/AnimationPlayer
@onready var option_menu = $UI/Control/OptionMenu
@onready var sfx_button = $UI/Control/OptionMenu/SFXButton
@onready var bgm_button = $UI/Control/OptionMenu/BGMButton

func _ready():
	_hook_button_sound(self)
	option_menu.position = Vector2(300,0)
	option_menu.size = Vector2(480,130)

func _hook_button_sound(node):
	for child in node.get_children():
		if child is Button:
			child.connect("pressed",Callable(click_sound,"play"))
		else :
			_hook_button_sound(child)


func _on_option_button_pressed():
	animation_player.play("show_options")


func _on_back_button_pressed():
	animation_player.play_backwards("show_options")


func _on_sfx_button_pressed():
	AudioServer.set_bus_mute(2,!AudioServer.is_bus_mute(2))
	if AudioServer.is_bus_mute(2) == true:
		sfx_button.text = "音效：关"
	else:
		sfx_button.text = "音效：开"


func _on_bgm_button_pressed():
	AudioServer.set_bus_mute(1,!AudioServer.is_bus_mute(1))
	if AudioServer.is_bus_mute(1) == true:
		bgm_button.text = "音乐：关"
	else:
		bgm_button.text = "音乐：开"

func _on_start_button_pressed():
	ScaneChanger.reload_world(target_path)


func _on_quite_button_pressed():
	get_tree().quit()


func _on_continue_button_pressed():
	pass # Replace with function body.
