extends Control
class_name Hotbar


onready var hotbar_red = $"Hotbar-Red"
onready var hotbar_orange = $"Hotbar-Orange"
onready var hotbar_yellow = $"Hotbar-Yellow"
onready var hotbar_green = $"Hotbar-Green"
onready var hotbar_blue = $"Hotbar-Blue"
onready var hotbar_violet = $"Hotbar-Violet"

onready var icon_blade = $"Icon-Blade"
onready var icon_shield = $"Icon-Shield"
onready var icon_missile = $"Icon-Missile"
onready var icon_burst = $"Icon-Burst"
onready var icon_shotgun = $"Icon-Shotgun"
onready var icon_gravity = $"Icon-Gravity"

var currentHotbar
var currentIcon

func _ready():
	Globals.set("hotbar", self)
	currentHotbar = hotbar_red
	currentIcon = icon_blade

func updateHotbar(clr: int):
	currentHotbar.visible = false
	currentIcon.visible = false
	
	match clr:
		Globals.colors.red:
			currentHotbar = hotbar_red
			currentIcon = icon_blade
		Globals.colors.yellow:
			currentHotbar = hotbar_yellow
			currentIcon = icon_shield
		Globals.colors.orange:
			currentHotbar = hotbar_orange
			currentIcon = icon_missile
		Globals.colors.green:
			currentHotbar = hotbar_green
			currentIcon = icon_burst
		Globals.colors.blue:
			currentHotbar = hotbar_blue
			currentIcon = icon_shotgun
		Globals.colors.violet:
			currentHotbar = hotbar_violet
			currentIcon = icon_gravity
		_:
			currentHotbar = hotbar_red
			currentIcon = icon_blade
	
	currentHotbar.visible = true
	currentIcon.visible = true
