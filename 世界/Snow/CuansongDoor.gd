extends Node2D


@onready var door_area1=$ChuanSongMeng1/Area2D
@onready var door_area2=$ChuanSongMeng2/Area2D

func _ready():
	door_area1.set_deferred("monitoring",false)
	door_area1.set_deferred("monitorable",false)
	
	door_area2.set_deferred("monitoring",false)
	door_area2.set_deferred("monitorable",false)
	set_deferred("visible",false)
	

func set_avaliable():
	door_area1.set_deferred("monitoring",true)
	door_area1.set_deferred("monitorable",true)
	
	door_area2.set_deferred("monitoring",true)
	door_area2.set_deferred("monitorable",true)
	
	set_deferred("visible",true)
	
func set_unavaliable():
	door_area1.set_deferred("monitoring",false)
	door_area1.set_deferred("monitorable",false)
	
	door_area2.set_deferred("monitoring",false)
	door_area2.set_deferred("monitorable",false)
	
	set_deferred("visible",false)
