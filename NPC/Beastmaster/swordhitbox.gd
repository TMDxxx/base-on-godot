extends "res://hitboxes_hurtboxes/hitbox.gd"

var coll = $CollisionPolygon2D
func _ready():
	coll.set_disabled(true)

