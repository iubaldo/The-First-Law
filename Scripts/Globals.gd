extends Node

enum colors { red, orange, yellow, green, blue, violet, white }

onready var asteroid01 = preload("res://Scenes/Asteroids/Asteroid 0-1.tscn")
onready var asteroid02 = preload("res://Scenes/Asteroids/Asteroid 0-2.tscn")
onready var asteroid03 = preload("res://Scenes/Asteroids/Asteroid 0-3.tscn")
onready var asteroid11 = preload("res://Scenes/Asteroids/Asteroid 1-1.tscn")
onready var asteroid12 = preload("res://Scenes/Asteroids/Asteroid 1-2.tscn")
onready var asteroid13 = preload("res://Scenes/Asteroids/Asteroid 1-3.tscn")
onready var asteroid21 = preload("res://Scenes/Asteroids/Asteroid 2-1.tscn")
onready var asteroid22 = preload("res://Scenes/Asteroids/Asteroid 2-2.tscn")
onready var asteroid23 = preload("res://Scenes/Asteroids/Asteroid 2-3.tscn")

onready var basicBulletTemplate = preload("res://Scenes/Bullets/BasicBullet.tscn")
onready var shotgunBulletTemplate = preload("res://Scenes/Bullets/ShotgunBullet.tscn")
onready var gravityBulletTemplate = preload("res://Scenes/Bullets/GravityBullet.tscn")
onready var burstBulletTemplate = preload("res://Scenes/Bullets/BurstBullet.tscn")
onready var missileBulletTemplace = preload("res://Scenes/Bullets/MissileBullet.tscn")

var mainScene
var player

var t0
var t1
var t2

var colorWhite
var colorRed
var colorOrange 
var colorYellow
var colorGreen
var colorBlue
var colorViolet

func _ready():
	OS.min_window_size = Vector2(1024, 576)
	
	t0 = [asteroid01, asteroid02, asteroid03]
	t1 = [asteroid11, asteroid12, asteroid13]
	t2 = [asteroid21, asteroid22, asteroid23]
	
	colorWhite = Color8(255, 255, 255)
	colorRed = Color8(176, 45, 35)
	colorOrange = Color8(204, 136, 35)
	colorYellow = Color8(219, 206, 55)
	colorGreen = Color8(107, 186, 37)
	colorBlue = Color8(38, 85, 173)
	colorViolet = Color8(125, 53, 196)
