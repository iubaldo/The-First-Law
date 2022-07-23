extends Bullet
class_name GravityBullet

const MAX_SPEED = 10 * 32
var acceleration = Vector2.ZERO
var target = null
var original = true
var steerForce = 15.0


func handleMovement(delta):
	var steerVel = Vector2.ZERO

	if target:
		var targetVel = (target.position - position).normalized() * velocity.length()
		steerVel = (targetVel - velocity).normalized() * steerForce

	acceleration += steerVel
	velocity += acceleration * delta
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)
	rotation = velocity.angle() + deg2rad(90)
	position += velocity * delta


func onLaunch(vec : Vector2, pos : Vector2, rot : float, clr: int):
	if original:
		velocity = rotateVector(vec, deg2rad(-30))
		velocity *= speed # rotating vector normalizes it
		rotation = rot + deg2rad(-30)
		
		var bulletInst = duplicate()
		bulletInst.target = self
		bulletInst.original = false
		target = bulletInst
		Globals.mainScene.get_node("Entities").add_child(bulletInst)
		bulletInst.launch(rotateVector(vec, deg2rad(30)), pos, rot + deg2rad(30), clr)


func rotateVector(vec : Vector2, delta : float):
	return Vector2(vec.x * cos(delta) - vec.y * sin(delta), vec.x * sin(delta) + vec.y * cos(delta))
