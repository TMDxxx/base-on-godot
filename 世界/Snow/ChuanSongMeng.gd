extends Node2D

@export var target_pos=Vector2.ZERO

@onready var door_area1=$ChuanSongMeng/Area2D

func _ready():
	door_area1.set_deferred("monitoring",false)
	door_area1.set_deferred("monitorable",false)
	set_deferred("visible",false)
	

func set_avaliable():
	door_area1.set_deferred("monitoring",true)
	door_area1.set_deferred("monitorable",true)
	set_deferred("visible",true)
	
func set_unavaliable():
	door_area1.set_deferred("monitoring",false)
	door_area1.set_deferred("monitorable",false)
	set_deferred("visible",false)
