extends Node2D

const BoxEffect = preload("res://Effects/BoxEffect.tscn")
func creadt_box_effect():
	var boxEffect = BoxEffect.instantiate()
	var world = get_tree().current_scene
	world.add_child(boxEffect)
	boxEffect.global_position = global_position


func _on_hurtbox_area_entered(area):
	creadt_box_effect()
	queue_free()
