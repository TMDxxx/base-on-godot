extends Control
var hearts = 4:
	set = set_hearts
var max_hearts = 4:
	set = set_max_hearts

@onready var lable = $Label

func set_hearts(value):
	hearts = clamp(value,0,max_hearts)
	print(hearts)
	if lable != null:
		lable.text= "HP = "+str(hearts)

func set_max_hearts(value):
	max_hearts = max(value,1)

func _ready():	
	self.max_hearts = BeastmasterStatus.max_health
	self.hearts = BeastmasterStatus.health
	BeastmasterStatus.connect("health_changed",Callable(self,"set_hearts"))
