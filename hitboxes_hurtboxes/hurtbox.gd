extends Area2D

const HitEffect = preload("res://Effects/sword_effect.tscn")
const damageHit = preload("res://Effects/demage_effect.tscn")

var invincible = false:
	set=set_invincible

@onready var timer = $Timer
signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func creat_hit_effect(damage):
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position
	var damagehit = damageHit.instantiate()
	main.add_child(damagehit)
	print(global_position)
	
	damagehit.damagehit(damage)
	damagehit.global_position = global_position


func _on_timer_timeout():
	self.invincible = false

func _on_hurtbox_invincibility_started():
	set_deferred("monitoring",false)
	set_deferred("monitorable",true)

func _on_hurtbox_invincibility_ended():
	set_deferred("monitoring",true)
	set_deferred("monitorable",true)



