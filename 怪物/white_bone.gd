extends CharacterBody2D

const white_bone_damged = preload("res://Effects/white_bone_damged.tscn")

@export var ACCELERATION = 220
@export var MAX_SPEED = 20
@export var FRICTION = 200
@export var WANDER_TARGET_RANGE = 4

enum {
	IDLE,
	WANDER,
	CHASE
}

var knockback = Vector2.ZERO

var state = IDLE

@onready var stats = $Stats
@onready var playDetectionZone = $PlayerDetectionZone
@onready var sprite = $AnimatedSprite2D
@onready var hurtbox = $hurtbox
@onready var softCollision = $SoftCollision 
@onready var wanderController = $WanderController

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO,FRICTION*delta)
	match state:
		IDLE:
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
				accelerate_toward_points(player.global_position,delta)
			else:
				state = IDLE
			
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta *400
	move_and_slide()

func accelerate_toward_points(point,delta):
	var dir = global_position.direction_to(point)
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
	stats.health -= area.damage
	velocity = area.knockback_vector * 120
	hurtbox.creat_hit_effect()
	
func _on_stats_no_health():
	queue_free()
	var white_bone_damge = white_bone_damged.instantiate()
	get_parent().add_child(white_bone_damge)
	white_bone_damge.global_position = global_position
	
