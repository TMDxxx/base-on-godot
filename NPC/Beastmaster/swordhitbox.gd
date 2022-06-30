extends "res://hitboxes_hurtboxes/hitbox.gd"

var kill_num=0
var coll = $CollisionPolygon2D
func _ready():
	coll.set_disabled(true)

func add_kill_num():
	kill_num+=1
