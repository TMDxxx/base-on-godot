extends CharacterBody2D


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

@onready var animationPlayer = $AnimatedSprite2D/AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var sprite = $AnimatedSprite2D
@onready var wanderController = $WanderController

var player_area=null

func _ready():
	animationTree.active = true
	
func _physics_process(delta):
	match state:
		IDLE:
			animationState.travel("IDLE")
			velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
			if wanderController.get_time_left() == 0:
				update_wander()
		
		WANDER:
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_toward_points(wanderController.target_position,delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		
		CHASE:
			pass
			
	move_and_slide()

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

	

