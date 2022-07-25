extends Node2D
class_name HealthBar

onready var hp_5 = $"HP-5"
onready var hp_4 = $"HP-4"
onready var hp_3 = $"HP-3"
onready var hp_2 = $"HP-2"
onready var hp_1 = $"HP-1"
onready var hp_0 = $"HP-0"

var currentSprite


func _ready():
	Globals.set("hpbar", self)
	currentSprite = hp_5


func updateHealthBar(newHP: int):
	currentSprite.visible = false
	match newHP:
		0: currentSprite = hp_0
		1: currentSprite = hp_1
		2: currentSprite = hp_2
		3: currentSprite = hp_3
		4: currentSprite = hp_4
		5: currentSprite = hp_5
		_: currentSprite = hp_0
		
	currentSprite.visible = true
