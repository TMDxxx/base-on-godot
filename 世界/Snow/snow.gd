extends Node2D

const Beastmaster = preload("res://NPC/Beastmaster/Beastmaster.tscn")
@export_file("*.tscn") var target_path = "res://世界/Village/Village.tscn"
@onready var timer=$Timer

var player = Beastmaster.instantiate()

var make_enemy_flag=false
var make_enemy_num=0
var make_enemy_time=0
var make_enemy_once=true
var base_kill_num=0
const MAX_ENEMY_NUM=5
const MAKE_ENEMY_TIME=2

func _ready():
	#var beastmaster = Beastmaster.instantiate()
	#player.position = Vector2(441,44)
	player.position = Vector2(-244,31)
	add_child(player)
	timer.start(1)

func _physics_process(delta):
	
	if make_enemy_flag:
		make_Enemys()
		

func make_Enemys():
	if make_enemy_once:
			make_enemy_once=false
			base_kill_num=player.kill_num
			
	if make_enemy_time >=MAKE_ENEMY_TIME:
		make_enemy_time=0
		make_enemys()
		make_enemy_num+=1
		
	if player.kill_num-base_kill_num>=MAX_ENEMY_NUM:
		print("successed")
		if make_enemy_num>=MAX_ENEMY_NUM :
			make_enemy_flag=false
	

func timeadder():
	make_enemy_time+=1
	

func make_enemys():
	var base_pos=Vector2(-244,31)
	var rand_pos=base_pos
	var startcount=get_child_count()
	var endcount=0
	var enemy= load("res://怪物/monster/mushy_1.tscn").instantiate()
	rand_pos=base_pos+Vector2(randf_range(-64,64),randf_range(-64,64))
	add_child(enemy)
	enemy.global_position=rand_pos
	endcount=get_child_count()
	
	

func _on_teleporter_body_entered(body):
	ScaneChanger.reload_world(target_path)


func _on_timer_timeout():
	timeadder()
