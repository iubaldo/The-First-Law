extends Area2D
class_name Asteroid
# defines asteroid behavior

var color: int = 0
var tier: int = 0

var velocity = Vector2.ZERO
var rotVelocity = 0


func _ready():
	add_to_group("asteroid")


func initialize():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var roll = rng.randi() % 20
	
	if roll <= 10:
		color = Globals.colors.white
	
	match roll:
		11: color = Globals.colors.red
		12: color = Globals.colors.orange
		13: color = Globals.colors.yellow
		14: color = Globals.colors.green
		15: color = Globals.colors.blue
		16: color = Globals.colors.violet


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
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var child1: Asteroid
	var child2: Asteroid
	
	if tier == 0:
		queue_free()
		return
	elif tier == 1:
		print("making tier 0 children")
		child1 = Globals.t0[rng.randi() % Globals.t0.size()].instance()
		child2 = Globals.t0[rng.randi() % Globals.t0.size()].instance()
		child1.tier = 0
		child2.tier = 0
	elif tier == 2:
		print("making tier 1 children")
		child1 = Globals.t1[rng.randi() % Globals.t1.size()].instance()
		child2 = Globals.t1[rng.randi() % Globals.t1.size()].instance()
		child1.tier = 1
		child2.tier = 1
	
	get_parent().call_deferred("add_child", child1)
	get_parent().call_deferred("add_child", child2)
	
	child1.color = self.color
	child2.color = self.color
	
	child1.position = self.position + Vector2(rng.randi_range(-50, 50), rng.randi_range(-50, 50))
	child1.velocity = rotateVector(velocity, rng.randi_range(-45, 45))
	child1.rotVelocity = rng.randf_range(-2, 2)
	child2.position = Vector2(self.position.x + rng.randi_range(-50, 50), self.position.y + rng.randi_range(-50, 50))
	child2.velocity = rotateVector(velocity, rng.randi_range(-45, 45))
	child2.rotVelocity = rng.randf_range(-2, 2)

	queue_free()


func rotateVector(vec : Vector2, delta : float):
	return Vector2(vec.x * cos(delta) - vec.y * sin(delta), vec.x * sin(delta) + vec.y * cos(delta))
