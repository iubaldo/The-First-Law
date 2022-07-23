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

var velocity = Vector2.ZERO
var rotVelocity = 0


func _ready():
	add_to_group("asteroid")
	

func _physics_process(delta):
	self.position += velocity * delta
	self.rotation += rotVelocity * delta


# split into 2 asteroids a tier below, or destroy self if tier 0
func destroy():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var child1: Asteroid
	var child2: Asteroid
	
	if tier == 0:
		queue_free()
	elif tier == 1:
		child1 = t0[rng.randi() % t1.size()].instance()
		child1.tier = 0
		child2 = t0[rng.randi() % t1.size()].instance()
		child2.tier = 0
	elif tier == 2:
		child1 = t1[rng.randi() % t1.size()].instance()
		child1.tier = 1
		child2 = t1[rng.randi() % t1.size()].instance()
		child2.tier = 1
	
	get_parent().add_child(child1)
	get_parent().add_child(child2)
	
	child1.position = Vector2(self.position.x + rng.randi_range(-10, 10), self.position.y + rng.randi_range(-10, 10))
	child1.velocity = Vector2(rng.randi_range(-10, 10), rng.randi_range(-10, 10))
	child1.rotVelocity = rng.randi_range(-5, 5)
	child2.position = Vector2(self.position.x + rng.randi_range(-10, 10), self.position.y + rng.randi_range(-10, 10))	
	child2.velocity = Vector2(rng.randi_range(-10, 10), rng.randi_range(-10, 10))
	child2.rotVelocity = rng.randi_range(-5, 5)

	queue_free()
