extends Area2D
class_name Asteroid
# defines asteroid behavior

onready var invulTimer = $Timer

signal updateScore(amount)

var invincible = false
var color: int = 0
var tier: int = 0

var velocity = Vector2.ZERO
var rotVelocity = 0


func _ready():
	add_to_group("asteroid")
	connect("updateScore", Globals.mainScene, "scoreUpdated")
	
	if invincible: 
		invulTimer.start()


func initialize():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var roll = rng.randi_range(1, 12)
	
	if roll <= 6: 
		applyColor(Globals.colors.white)
	match roll:
		7: applyColor(Globals.colors.red)
		8: applyColor(Globals.colors.orange)
		9: applyColor(Globals.colors.yellow)
		10: applyColor(Globals.colors.green)
		11: applyColor(Globals.colors.blue)
		12: applyColor(Globals.colors.violet)


func applyColor(clr: int):
	color = clr
	match color:
		Globals.colors.white: $Sprite.modulate = Globals.colorWhite
		Globals.colors.red: $Sprite.modulate = Globals.colorRed
		Globals.colors.orange: $Sprite.modulate = Globals.colorOrange
		Globals.colors.yellow: $Sprite.modulate = Globals.colorYellow
		Globals.colors.green: $Sprite.modulate = Globals.colorGreen
		Globals.colors.blue: $Sprite.modulate = Globals.colorBlue
		Globals.colors.violet: $Sprite.modulate = Globals.colorViolet
		_: $Sprite.modulate = Globals.colorWhite
	

func _physics_process(delta):
	self.position += velocity * delta
	self.rotation += rotVelocity * delta


func launch(var vel: Vector2, var rotVel: int, var pos: Vector2, var rot: float):
	velocity = vel
	rotVelocity = rotVel
	position = pos
	rotation = rot


# split into 2 asteroids a tier below, or destroy self if tier 0
func destroy():
	if invincible:
		return
	
	emit_signal("updateScore", 100)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var child1: Asteroid
	var child2: Asteroid
	
	if tier == 0:
		queue_free()
		return
	elif tier == 1:
		child1 = Globals.t0[rng.randi() % Globals.t0.size()].instance()
		child2 = Globals.t0[rng.randi() % Globals.t0.size()].instance()
		child1.tier = 0
		child2.tier = 0
	elif tier == 2:
		child1 = Globals.t1[rng.randi() % Globals.t1.size()].instance()
		child2 = Globals.t1[rng.randi() % Globals.t1.size()].instance()
		child1.tier = 1
		child2.tier = 1
	
	get_parent().call_deferred("add_child", child1)
	get_parent().call_deferred("add_child", child2)
	
	child1.applyColor(self.color)
	child2.applyColor(self.color)
	
	child1.position = self.position + Vector2(rng.randi_range(-50, 50), rng.randi_range(-50, 50))
	child1.velocity = rotateVector(velocity, rng.randi_range(-45, 45))
	child1.rotVelocity = rng.randf_range(-2, 2)
	child2.position = Vector2(self.position.x + rng.randi_range(-50, 50), self.position.y + rng.randi_range(-50, 0))
	child2.velocity = rotateVector(velocity, rng.randi_range(-45, 45))
	child2.rotVelocity = rng.randf_range(-2, 2)
	
	child1.invincible = true
	child2.invincible = true

	queue_free()


func rotateVector(vec : Vector2, delta : float):
	return Vector2(vec.x * cos(delta) - vec.y * sin(delta), vec.x * sin(delta) + vec.y * cos(delta))


func _on_Timer_timeout():
	invincible = false
