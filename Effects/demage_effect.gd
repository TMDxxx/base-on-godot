extends Control
@onready var timer = $Timer
@onready var label = $Label

func damagehit(damage):
	timer.start(0.5)
	print(damage)
	label.text = "-"+str(damage)
	

func _on_timer_timeout():
	queue_free()
