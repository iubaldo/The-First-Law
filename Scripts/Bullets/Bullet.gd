extends Area2D
class_name Bullet
# abstract class that defines bullet behavior

var color: int = 0
var velocity: Vector2
var speed = 15 * 32


func _ready():
	add_to_group("bullet")


# abstract
func onReady():
	pass


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
		onHit(body)


#hit an asteroid or another bullet
func _on_Bullet_area_entered(area):
	if area.is_in_group("asteroid"):
		if color == area.color || color == Globals.colors.white || area.color == Globals.colors.white:
			area.destroy()
			onHit(area)


# abstract
func onHit(target):
	queue_free()
