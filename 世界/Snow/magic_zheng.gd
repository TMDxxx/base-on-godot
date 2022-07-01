extends Node2D
var player_area=null
var playeron_num=0
@onready var stats = $Stats
@onready var hurtbox = $hurtbox
@onready var MagicHurt=$MagicHurt
@onready var magicHurtAni=$MagicHurtAni
@onready var playerOn=$PlayerOn

signal playeron_once

func _ready():
	MagicHurt.set_deferred("visible",false)
	
	set_deferred("visible",false)
	hurtbox.set_deferred("monitoring",false)
	hurtbox.set_deferred("monitorable",false)
	playerOn.set_deferred("monitoring",false)
	playerOn.set_deferred("monitorable",false)
	
func set_avaliable(flag):
	if flag:
		set_deferred("visible",true)
		hurtbox.set_deferred("monitoring",true)
		hurtbox.set_deferred("monitorable",true)
		playerOn.set_deferred("monitoring",true)
		playerOn.set_deferred("monitorable",true)
	else:
		set_deferred("visible",false)
		hurtbox.set_deferred("monitoring",false)
		hurtbox.set_deferred("monitorable",false)
		playerOn.set_deferred("monitoring",false)
		playerOn.set_deferred("monitorable",false)
	

func hurt_ani_end():
	MagicHurt.set_deferred("visible",false)

func _on_hurtbox_area_entered(area):
	MagicHurt.set_deferred("visible",true)
	magicHurtAni.play("magichurt")
	player_area=area
	stats.health -= area.damage
	hurtbox.creat_hit_effect(area.damage)


func _on_stats_no_health():
	player_area.add_kill_num()
	queue_free()


func _on_player_on_body_entered(body):
	if playeron_num <=0:
		emit_signal("playeron_once")
	playeron_num+=1
	
