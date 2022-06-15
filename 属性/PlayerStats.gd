extends Node2D

@export var max_health = 1
@onready var health = max_health :
	set=set_health
		


signal no_health
signal health_changed(value)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health<=0:
		emit_signal("no_health")

func get_health(value):
	
	pass
