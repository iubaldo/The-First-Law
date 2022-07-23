extends Area2D
class_name Asteroid
# defines asteroid behavior


onready var asteroid01 = preload("res://Scenes/Asteroids/Asteroid 0-1.tscn")
onready var asteroid02 = preload("res://Scenes/Asteroids/Asteroid 0-2.tscn")
onready var asteroid03 = preload("res://Scenes/Asteroids/Asteroid 0-3.tscn")
onready var asteroid11 = preload("res://Scenes/Asteroids/Asteroid 1-1.tscn")
onready var asteroid12 = preload("res://Scenes/Asteroids/Asteroid 1-2.tscn")
onready var asteroid13 = preload("res://Scenes/Asteroids/Asteroid 1-3.tscn")
onready var asteroid21 = preload("res://Scenes/Asteroids/Asteroid 2-1.tscn")
onready var asteroid22 = preload("res://Scenes/Asteroids/Asteroid 2-2.tscn")
onready var asteroid23 = preload("res://Scenes/Asteroids/Asteroid 2-3.tscn")

var tier: int = 0
var t0 = [asteroid01, asteroid02, asteroid03]
var t1 = [asteroid11, asteroid12, asteroid13]
var t2 = [asteroid21, asteroid22, asteroid23]

func _ready():
	add_to_group("asteroid")	
	pass


func destroy():
	if tier == 2:
		randomize()
		var child1 = t1[randi() % t1.size()].instance()
		var child2 = t1[randi() % t1.size()].instance()
		
		get_parent().add_child(child1)
		get_parent().add_child(child2)
