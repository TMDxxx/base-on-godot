extends Control

var hearts = 4: set = set_hearts
var max_hearts = 4: set = set_max_hearts

@onready var HP = $VBoxContainer/HBoxContainer/Control/HBoxContainer/GridContainer/HP
@onready var MP = $VBoxContainer/HBoxContainer/Control/HBoxContainer/GridContainer/MP
@onready var pause_menu = $PauseMenu
@onready var you_die = $YouDie
@onready var beastmaster_status = BeastmasterStatus

func set_hearts(value):
	hearts = clamp(value,0,max_hearts)
	if HP != null:
		HP.value = hearts

func set_max_hearts(value):
	max_hearts = max(value,1)
	if HP != null:
		HP.max_value = max_hearts

func _ready():
	self.max_hearts = beastmaster_status.max_health
	self.hearts = beastmaster_status.health
	beastmaster_status.connect("health_changed",Callable(self,"set_hearts"))
	beastmaster_status.connect("max_health_changed",Callable(self,"set_max_hearts"))
	beastmaster_status.connect("no_health",Callable(self,"you_die_show_menu"))


func _on_setting_pressed():
	pause_menu.show_menu()


func you_die_show_menu():
	you_die.show_menu()
