extends "res://hitboxes_hurtboxes/hitbox.gd"

var knockback_vector = Vector2.ZERO
var coll = $CollisionShape2D
func _ready():
	coll.set_disabled(true)

