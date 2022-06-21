extends CharacterBody2D

@export var ACCELERATION = 2500
@export var MAX_SPEED = 2000
@export var ROLL_SPEED = 75
@export var FRICTION = 1000

enum{
	MOVE,
	ROLL,
	ATTACK
}

var roll_vector = Vector2.DOWN
var state=MOVE
var stats = BeastmasterStatus

@onready var animationPlayer = $AnimatedSprite2D/AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var swordHitbox = $HitboxPivot/swordHitbox
@onready var hurtbox = $hurtbox

func _ready():
	randomize()
	stats.connect("no_health",Callable(self,"queue_free"))
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if velocity != Vector2.ZERO:
		roll_vector = velocity
		swordHitbox.knockback_vector = velocity
		animationTree.set("parameters/idle/blend_position",velocity)
		animationTree.set("parameters/walk/blend_position",velocity)
		animationTree.set("parameters/Attack/blend_position",velocity)
		animationTree.set("parameters/Roll/blend_position",velocity)
		animationState.travel("walk")
		velocity=velocity.move_toward(velocity * MAX_SPEED, ACCELERATION * delta) # 
	else:
		animationState.travel("idle")
		velocity=velocity.move_toward(Vector2.ZERO, FRICTION * delta) # 施加摩擦力
	move()
	if Input.is_action_just_pressed("roll"):
		state=ROLL
	if Input.is_action_just_pressed("attack"):
		state=ATTACK
	
	
func roll_state(_delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()
	
func attack_state(_delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
	
func move():
	move_and_slide() #
	
func attack_animation_finished():
	state=MOVE

func roll_animation_finished():
	velocity=velocity*0.7
	state=MOVE


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(1) #一秒无敌
	hurtbox.creat_hit_effect(area.damage)
