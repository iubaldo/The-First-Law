extends Node
class_name GameManager
# manages game entities and data

onready var spawnTimer = $"Asteroid Spawn Timer"

var bounds: Rect2
const MIN_SPAWN_RADIUS = 650
const MAX_SPAWN_RADIUS = 750

# player stuff
var score: int
var playerHP: int = 5 # maybe change based on difficulty later (5/3/1)?
var invincible = false

# controller variables
var usingController = false
const deadzone0 = 0.3

func _ready():
	Globals.set("mainScene", self)
	
	var screenSize = Vector2(get_viewport().get_visible_rect().size.x - 10, get_viewport().get_visible_rect().size.y - 10)
	bounds = Rect2(Vector2(10, 10), screenSize)


func _input(_event):
	if Input.is_action_just_pressed("debug_start"): # replace with some sort of animation of "press any key to start"
		spawnTimer.start()


func damagePlayer():
	playerHP -= 1
	invincible = true
	$"Invincibility Timer".start()
	
	if playerHP <= 0:
		endGame()


func endGame():
	print("you lose!")
	pass


# teleports player when they reach the end of the screen
func _on_Area_Bounds_body_exited(body):
	if body.position.x <= 10:
		body.position = Vector2(bounds.size.x, body.position.y)
	elif body.position.x >= bounds.size.x:
		body.position = Vector2(0, body.position.y)
	elif body.position.y <= 10:
		body.position = Vector2(body.position.x, bounds.size.y)
	elif body.position.y >= bounds.size.y:
		body.position = Vector2(body.position.x, 0)


func _on_Area_Bounds_area_exited(area):
	if area.is_in_group("asteroid"):
		area.queue_free()
	
	if area.position.x <= 10:
		area.position = Vector2(bounds.size.x, area.position.y)
	elif area.position.x >= bounds.size.x:
		area.position = Vector2(0, area.position.y)
	elif area.position.y <= 10:
		area.position = Vector2(area.position.x, bounds.size.y)
	elif area.position.y >= bounds.size.y:
		area.position = Vector2(area.position.x, 0)


func _on_Invincibility_Timer_timeout():
	invincible = false


# spawn a new asteroid
func _on_Asteroid_Spawn_Timer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# where to spawn the asteroid
	var angle = rng.randi_range(0, 360)
	var radius = rng.randi_range(MIN_SPAWN_RADIUS, MAX_SPAWN_RADIUS)
	var spawnPos = Vector2(radius * cos(angle), radius * sin(angle)) + Globals.player.global_position
	
	# where to aim the asteroid
	angle = rng.randi_range(0, 360)
	radius = rng.randi_range(0, 400)
	var targetPos = Vector2(radius * cos(angle), radius * sin(angle)) + Globals.player.global_position
	var targetVec = (targetPos - spawnPos).normalized()
	var targetVel = targetVec * rng.randi_range(50, 70)
	
	var rotVel = rng.randf_range(-2, 2)
	
	var tier = rng.randi_range(0, 2)
	var asteroidInst: Asteroid
	match tier:
		0: asteroidInst = Globals.t0[rng.randi() % Globals.t0.size()].instance()
		1: asteroidInst = Globals.t1[rng.randi() % Globals.t1.size()].instance()
		2: asteroidInst = Globals.t2[rng.randi() % Globals.t2.size()].instance()
		_: asteroidInst = Globals.t1[rng.randi() % Globals.t1.size()].instance()
	
	$Entities.add_child(asteroidInst)
	asteroidInst.tier = tier
	asteroidInst.launch(targetVel, rotVel, spawnPos, angle)
	print("launched asteroid from " + var2str(spawnPos) + ", targeting " + var2str(targetPos))
	
	spawnTimer.wait_time = rng.randi_range(6, 10)
	spawnTimer.start()
