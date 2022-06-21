extends Control

var hearts = 4: set = set_hearts
var max_hearts = 4: set = set_max_hearts

@onready var HP = get_node("HBoxContainer/GridContainer/HP")
@onready var EXP = get_node("HBoxContainer/GridContainer/EXP")

func set_hearts(value):
	hearts = clamp(value,0,max_hearts)
	if HP != null:
		HP.value = hearts

func set_max_hearts(value):
	max_hearts = max(value,1)
	if HP != null:
		HP.max_value = max_hearts

func _ready():
	self.max_hearts = BeastmasterStatus.max_health
	self.hearts = BeastmasterStatus.health
	BeastmasterStatus.connect("health_changed",Callable(self,"set_hearts"))
	BeastmasterStatus.connect("max_health_changed",Callable(self,"set_max_hearts"))
