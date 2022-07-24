extends Area2D
class_name Bullet
# abstract class that defines bullet behavior

var color: int = 0
var velocity: Vector2
var speed = 15 * 32


func _physics_process(delta):
	onPhysicsProcess(delta)
	handleMovement(delta)


func handleMovement(delta):
	self.position += velocity * delta


# abstract
func onPhysicsProcess(delta):
	pass


func launch(vec: Vector2, pos: Vector2, rot: float, clr: int):
	velocity = vec * speed
	position = pos
	rotation = rot
	color = clr

	onLaunch(vec, pos, rot, clr)


# abstract
func onLaunch(vec: Vector2, pos: Vector2, rot: float, clr: int): 
	pass


# hit the player
func _on_Bullet_body_entered(body):
	if body.is_in_group("player"):
		Globals.mainScene.damagePlayer()
		queue_free()


#hit an asteroid or another bullet
func _on_Bullet_area_entered(area):
	if area.is_in_group("asteroid"):
		area.destroy()
		queue_free()
