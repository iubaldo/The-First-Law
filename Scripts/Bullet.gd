extends KinematicBody2D
class_name Bullet
# abstract class that defines bullet behavior

enum colors { red, orange, yellow, green, blue, violet }

var parent
var color: int = 0
var velocity = Vector2.ZERO


func _physics_process(delta):
	onPhysicsProcess(delta)
	self.position += velocity * delta


# abstract
func onPhysicsProcess(delta):
	pass


func launch(vel: Vector2, pos: Vector2, rot: float, origin):
	velocity = vel
	position = pos
	rotation = rot
	parent = origin

	onLaunch(vel, pos, rot, origin)


# abstract
func onLaunch(vel: Vector2, pos: Vector2, rot: float, origin): 
	pass


# hit the player
func _on_Bullet_body_entered(body):
	if body.is_in_group("player"):
		GameManager.damagePlayer()


#hit an asteroid or another bullet
func _on_Bullet_area_entered(area):
	if area.is_in_group("asteroid"):
		area.destroy()
