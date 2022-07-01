extends Node2D

const Beastmaster = preload("res://NPC/Beastmaster/Beastmaster.tscn")
@export_file("*.tscn") var target_path = "res://世界/Village/Village.tscn"
@onready var timer=$Timer
@onready var chuansongmeng=$CuansongDoor
@onready var magicZheng1=$FaZheng/MagicZheng
@onready var magicZheng2=$FaZheng/MagicZheng2
@onready var magicZheng3=$FaZheng/MagicZheng3

var player = Beastmaster.instantiate()

var make_enemy_pos=Vector2.ZERO
var make_enemy_timing=0
var make_enemy_numing=0

var make_jitang_enemy_flag=false
var make_enemy_flag=false
var make_enemy_num=0
var make_enemy_time=0
var make_enemy_once=true
var base_kill_num=0

var make_fazheng_flag=false

signal fazheng_all_break

func _ready():
	#var beastmaster = Beastmaster.instantiate()
	#player.position = Vector2(462,288)
	player.position = Vector2(-280,322)
	add_child(player)
	timer.start(1)

func _process(delta):
	if make_enemy_flag:
		make_Enemys(make_enemy_pos,make_enemy_numing,make_enemy_timing)
	
	if make_jitang_enemy_flag:
		#print(make_enemy_numing)
		make_JiTangEnemys(make_enemy_pos,make_enemy_numing,make_enemy_timing)
	if make_fazheng_flag:
		is_AllMagicZheng_Break()
		
func is_AllMagicZheng_Break():
	#if magicZheng1==null and magicZheng2==null and magicZheng3==null:
	if magicZheng2==null:
		emit_signal("fazheng_all_break")
		make_fazheng_flag=false
		

func make_JiTangEnemys(pos,numing,timeing):
	if make_enemy_once:
			make_enemy_once=false
			base_kill_num=player.kill_num
	if player.kill_num-base_kill_num>=numing:
		chuansongmeng.set_avaliable()
		make_jitang_enemy_flag=false
		make_enemy_num=0
	if make_enemy_time >=timeing and make_enemy_num<numing+2:
		make_enemy_time=0
		make_enemys(pos)
		make_enemy_num+=1
	#print(player.kill_num)
		
func make_Enemys(pos,numing,timeing):
	#print(make_enemy_time)
	if make_enemy_num>=numing:
		#print("end:",make_enemy_num)
		make_enemy_flag=false
		make_enemy_num=0
	elif make_enemy_time >=timeing:
		make_enemy_time=0
		make_enemys(pos)
		make_enemy_num+=1
	

func timeadder():
	make_enemy_time+=1
	

func make_enemys(pos):
	var base_pos=pos
	var rand_pos=base_pos
	var startcount=get_child_count()
	var endcount=0
	var enemy= load("res://怪物/monster/mushy_1.tscn").instantiate()
	rand_pos=base_pos+Vector2(randf_range(-80,80),randf_range(-80,80))
	add_child(enemy)
	enemy.position=rand_pos
	var WanderController=enemy.get_node("WanderController")
	WanderController.start_position=rand_pos
	endcount=get_child_count()
	
	

func _on_teleporter_body_entered(body):
	ScaneChanger.reload_world(target_path)


func _on_timer_timeout():
	timeadder()


func _on_magic_zheng1_playeron_once():
	make_enemy_flag=true
	make_enemy_pos=Vector2(-286,644)
	make_enemy_timing=1
	make_enemy_numing=6


func _on_magic_zheng_2_playeron_once():
	make_enemy_flag=true
	make_enemy_pos=Vector2(-1050,306)
	make_enemy_timing=1
	make_enemy_numing=6


func _on_magic_zheng_3_playeron_once():
	make_enemy_flag=true
	make_enemy_pos=Vector2(204,128)
	make_enemy_timing=1
	make_enemy_numing=6

func _on_ji_tang_playeron_once():
	make_jitang_enemy_flag=true
	make_enemy_pos=Vector2(-280,322)
	make_enemy_timing=2
	make_enemy_numing=5


func _on_sheng_dan_playeron_once():
	make_fazheng_flag=true
	magicZheng1.set_avaliable(true)
	magicZheng2.set_avaliable(true)
	magicZheng3.set_avaliable(true)
