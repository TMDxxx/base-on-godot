extends CanvasLayer

var dialogs = []
var current = 0

@export var interval = 0.1


@onready var content = $Content
@onready var texture_rect = $Content/TextureRect
@onready var visibles = "visible_characters"
@onready var tween = get_tree().create_tween()
func _ready():
	hide_dialog_box()

func hide_dialog_box():
	content.hide()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if tween.is_running():
			tween.kill()
			content.percent_visible = 1
			texture_rect.show()
		elif current+1 <dialogs.size():
			_show_dialog(current+1)
		else:
			hide_dialog_box()
		# get_tree().set_input_as_handled()
	
func show_dialog_box(_dialogs):
	BeastmusterUi.hide()
	dialogs = _dialogs
	content.show()
	_show_dialog(0)


func _show_dialog(index):
	current = index
	print(index)
	var dialog = dialogs[current]
	content.text = dialog.text
	
	texture_rect.hide()
	
	tween.interpolate_value(
		content,"percent_visible",0,1,
		interval ,
		Tween.TRANS_LINEAR
	)
	texture_rect.show()
	tween.finished
	


func _on_content_visibility_changed():
	get_tree().paused =content.visible
