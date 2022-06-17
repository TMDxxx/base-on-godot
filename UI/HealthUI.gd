extends Control
var hearts = 4: set = set_hearts
var max_hearts = 4: set = set_max_hearts

@onready var heartUIEmpty = $HeartUIEmpty
@onready var heartFull = $HealthFull

func set_hearts(value):
	hearts = clamp(value,0,max_hearts)
	if heartFull != null:
		heartFull.size.x = hearts * 16

func set_max_hearts(value):
	max_hearts = max(value,1)
	print(max_hearts)
	
	if heartUIEmpty != null:
		heartUIEmpty.size.x = max_hearts * 16

func _ready():
	self.max_hearts = BeastmasterStatus.max_health
	self.hearts = BeastmasterStatus.health
	BeastmasterStatus.connect("health_changed",Callable(self,"set_hearts"))
	BeastmasterStatus.connect("max_health_changed",Callable(self,"set_max_hearts"))
