extends Control

var title = "res://UI/title_screen.tscn"

func show_menu():
	show()


func hide_menu():
	hide()



func _on_resume_button_pressed():
	hide_menu()


func _on_quit_button_pressed():
	hide_menu()
	ScaneChanger.reload_world(title)


func _on_pause_menu_visibility_changed():
	if get_tree() != null:
		get_tree().paused = visible
