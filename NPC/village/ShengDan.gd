extends CharacterBody2D

const white_bone_damged = preload("res://Effects/sword_effect.tscn")

@export var ACCELERATION = 220
@export var MAX_SPEED = 40
@export var FRICTION = 200
@export var WANDER_TARGET_RANGE = 4


enum {
	IDLE,
	WANDER,
	CHASE
}

var knockback = Vector2.ZERO

var state = IDLE

@onready var animationPlayer = $AnimatedSprite2D/AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var hit = $hit
@onready var stats = $Stats
@onready var playDetectionZone = $PlayerDetectionZone
@onready var sprite = $AnimatedSprite2D
@onready var hurtbox = $hurtbox
@onready var hitbox = $hitbox
@onready var softCollision = $SoftCollision 
@onready var wanderController = $WanderController
@onready var aniBubble=$AniBubble


var player_area=null
var playeron_num=0
var all_fazheng_break_flag=false

signal  playeron_once

func _ready():
	aniBubble.set_deferred("visible",false)
	animationTree.active = true
	hitbox.knockback_vector = velocity.normalized()
	
func _physics_process(delta):
	match state:
		IDLE:
			animationState.travel("IDLE")
			velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
		
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_toward_points(wanderController.target_position,delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		
		CHASE:
			var player = playDetectionZone.player
			if player!=null:
				var ve = player.global_position
				accelerate_toward_points(ve,delta)
			else:
				state = IDLE
			
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta *400
	hitbox.knockback_vector = velocity
	move_and_slide()

func _unhandled_input(event):
	if  aniBubble.visible==true and event.is_action_pressed("ensure"):
		if all_fazheng_break_flag:
			DialogBox.show_dialog_box([
				{text="所有魔法阵都已经被破坏"},
				{text="通向驯鹿离开方向的传送门已经打开"},
				{text="帮我把他带回来"}
				])
		else:
			if playeron_num<=0:
				DialogBox.show_dialog_box([
				{text="我的驯鹿跑了，帮我找回来"}])
				emit_signal("playeron_once")
			else:
				DialogBox.show_dialog_box([
				{text="魔法阵还没有全部破坏，请前往地图最左端，下方山谷，上方小屋破坏。"}])
			

func accelerate_toward_points(point,delta):
	var dir = global_position.direction_to(point)
	animationTree.set("parameters/IDLE/blend_position",dir)
	animationTree.set("parameters/WALK/blend_position",dir)
	animationState.travel("WALK")
	velocity = velocity.move_toward(dir * MAX_SPEED,ACCELERATION*delta)
	
	#sprite.flip_h = velocity.x < 0 #方向改变
	
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func update_wander():
	state = pick_random_state([IDLE,WANDER])
	wanderController.start_wander_timer(randf_range(1,3))

func seek_player():
	if playDetectionZone.can_see_player():
		state = CHASE

func _on_hurtbox_area_entered(area):
	player_area=area
	stats.health -= area.damage
	velocity = area.knockback_vector * 120
	hurtbox.creat_hit_effect(area.damage)
	#hit.play()
	
func _on_stats_no_health():
	player_area.add_kill_num()
	queue_free()
	var white_bone_damge = white_bone_damged.instantiate()
	get_parent().add_child(white_bone_damge)
	white_bone_damge.global_position = global_position
	



func _on_talk_area_body_entered(body):
	aniBubble.set_deferred("visible",true)


func _on_talk_area_body_exited(body):
	aniBubble.set_deferred("visible",false)


func _on_snow_fazheng_all_break():
	all_fazheng_break_flag=true
