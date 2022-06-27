extends Control

var title = "res://UI/title_screen.tscn"

func show_menu():
	show()


func hide_menu():
	hide()


func _on_back_menu_pressed():
	hide_menu()
	ScaneChanger.reload_world(title)


func _on_you_die_visibility_changed():
	if get_tree() != null:
		get_tree().paused = visible
