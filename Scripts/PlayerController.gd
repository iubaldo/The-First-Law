extends KinematicBody2D
class_name Player
# handles player controls


# movement variables
var velocity: Vector2
const ACCELERATION = 20 * 32
const MAX_SPEED = 16 * 32
const FRICTION = 0.95
const ROTATION_SPEED = 5

# shooting variables
var shootVector: Vector2 = Vector2.UP
var bulletType: int = Globals.colors.white
var bulletColor: int = Globals.colors.white


func _ready():
	Globals.set("player", self)
	add_to_group("player")


func _input(_event):
	if Input.is_action_pressed("shoot") && $ShootCD.is_stopped():
		var bullet: Bullet
		
		match bulletType:
			Globals.colors.white: 
				bullet = Globals.basicBulletTemplate.instance() # change later to modify current bullet to be white
				bulletColor = Globals.colors.white
			Globals.colors.red: 
				bulletColor = Globals.colors.red
			Globals.colors.orange:
				bulletColor = Globals.colors.orange
			Globals.colors.yellow: 
				bullet = Globals.burstBulletTemplate.instance()
				bulletColor = Globals.colors.yellow
			Globals.colors.green:
				bulletColor = Globals.colors.green
			Globals.colors.blue: 
				bullet = Globals.shotgunBulletTemplate.instance()
				bulletColor = Globals.colors.blue
			Globals.colors.violet: 
				bullet = Globals.gravityBulletTemplate.instance()
				bulletColor = Globals.colors.violet
			_: 
				bullet = Globals.basicBulletTemplate.instance()
				bulletColor = Globals.colors.white
		
		get_parent().add_child(bullet)
		bullet.applyColor(bulletColor)
		bullet.launch(shootVector, $"Bullet Spawn".global_position, self.rotation, bulletType)
		$ShootCD.start()
	
	if Input.is_action_just_pressed("bullet0"):
		bulletType = Globals.colors.white
		print("switched to white bullet")
	elif Input.is_action_just_pressed("bullet1"):
		bulletType = Globals.colors.red
		print("switched to red bullet")
	elif Input.is_action_just_pressed("bullet2"):
		bulletType = Globals.colors.orange
		print("switched to orange bullet")
	elif Input.is_action_just_pressed("bullet3"):
		bulletType = Globals.colors.yellow
		print("switched to yellow bullet")
	elif Input.is_action_just_pressed("bullet4"):
		bulletType = Globals.colors.green
		print("switched to green bullet")
	elif Input.is_action_just_pressed("bullet5"):
		bulletType = Globals.colors.blue
		print("switched to blue bullet")
	elif Input.is_action_just_pressed("bullet6"):
		bulletType = Globals.colors.violet
		print("switched to violet bullet")


func _physics_process(delta):
	var moveVector = handleMoveInput()
	applyMovement(moveVector, delta)
	
	if Input.is_action_pressed("rotate_cw"):
		rotation += ROTATION_SPEED * delta
	elif Input.is_action_pressed("rotate_ccw"):
		rotation -= ROTATION_SPEED * delta
		
	shootVector = Vector2(sin(rotation), -cos(rotation))


func handleMoveInput() -> Vector2:
	var moveVector = Vector2.ZERO
	if !Globals.mainScene.usingController:
		var inputVector = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") , \
			 Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
		moveVector = inputVector.normalized()
	else:
		var inputVector = Vector2(Input.get_joy_axis(0, JOY_AXIS_0), Input.get_joy_axis(0, JOY_AXIS_1))
		if inputVector.length() >= GameManager.deadzone0:
			moveVector = inputVector.normalized()
	return moveVector
	

func applyMovement(moveVector, delta):
	if moveVector != Vector2.ZERO:
		velocity.x += moveVector.x * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		velocity.y += moveVector.y * ACCELERATION * delta
		velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)
	
	if Input.is_action_pressed("brake"):
		velocity *= FRICTION
		
	var _temp = move_and_slide(transform.basis_xform(velocity), Vector2.UP) # given a variable so the editor stops yelling
