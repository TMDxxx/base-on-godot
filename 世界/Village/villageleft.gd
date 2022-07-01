extends Node2D

@export_file("*.tscn") var target_path_R = "res://世界/Village/cunzhuang.tscn"
const Slime = preload("res://怪物/monster/slime_1.tscn")
@onready var beastmaster = $Beastmaster
@onready var left = $trans/LEFT
@onready var right = $trans/RIGHT
@onready var up = $trans/UP
@onready var down = $trans/DOWN
@onready var slimes = $slimes


var transfer = false
var dir = 0

func _ready():
	beastmaster.position=positions(GlobalData.return_num())
	


func _process(delta):
	#print(transfer)
	if Input.is_action_pressed("ensure") and transfer == true:
		GlobalData.change_num(dir)
		transfer = false
		ScaneChanger.reload_world(target_path_R)
		
	if slimes.get_child_count() < 10:
		var slime = Slime.instantiate()
		slime.position = Vector2(randf_range(600,900),randf_range(600,900))
		slimes.add_child(slime)
	

func positions(num):
	if num==0:
		return left.position
	elif num==1:
		return right.position
	elif num==2:
		return up.position
	elif num==3:
		return down.position


func _on_right_body_entered(body):
	print("in")
	transfer = true
	dir = 0


func _on_right_body_exited(body):
	print("leve")
	transfer = false
