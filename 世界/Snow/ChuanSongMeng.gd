extends Node2D

@export var target_pos=Vector2.ZERO




	





func _on_area_2d_body_entered(body) :
	body.position=target_pos

