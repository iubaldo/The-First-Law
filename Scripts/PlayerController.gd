extends KinematicBody2D
class_name Player
# handles player controls

# preloads
onready var playerSprite = $"Player Sprite"
onready var animationPlayer = $AnimationPlayer
onready var flightTrail1 = $"Flight Trail 1"
onready var flightTrail2 = $"Flight Trail 2"
onready var explosion = $MissileExplosion

signal bulletChanged(clr)
signal finishedDeathAnim

# movement variables
var dashing = false # movement is locked while dashing
var velocity: Vector2
const ACCELERATION = 20 * 32
const DASH_SPEED = 48 * 32
const MAX_SPEED = 16 * 32
const FRICTION = 0.95
const ROTATION_SPEED = 5

# shooting variables
var shootVector: Vector2 = Vector2.UP
var bulletColor: int = Globals.colors.white

var whiteCD = 0.5
var redCD = 0.3
var yellowCD = 1
var orangeCD = 3
var greenCD = 1
var blueCD = 0.75
var violetCD = 1


func _ready():
	Globals.set("player", self)
	add_to_group("player")
	connect("bulletChanged", Globals.hotbar, "updateHotbar")


func _input(_event):
	if Input.is_action_pressed("shoot") && $ShootCD.is_stopped():
		var bullet: Bullet
		
		match bulletColor:
			Globals.colors.white: 
				bullet = Globals.basicBulletTemplate.instance() # change later to modify current bullet to be white
				$ShootCD.wait_time = whiteCD
			Globals.colors.red: 
				bullet = $Blade
				$ShootCD.wait_time = redCD
			Globals.colors.orange:
				bullet = $Shield
				$ShootCD.wait_time = orangeCD
			Globals.colors.yellow: 
				bullet = Globals.missileBulletTemplate.instance()
				$ShootCD.wait_time = yellowCD
			Globals.colors.green:
				bullet = Globals.burstBulletTemplate.instance()
				$ShootCD.wait_time = greenCD
			Globals.colors.blue: 
				bullet = Globals.shotgunBulletTemplate.instance()
				$ShootCD.wait_time = blueCD
			Globals.colors.violet: 
				bullet = Globals.gravityBulletTemplate.instance()
				$ShootCD.wait_time = violetCD
			_: 
				bullet = Globals.basicBulletTemplate.instance()
				$ShootCD.wait_time = whiteCD
		
		if bulletColor != Globals.colors.red && bulletColor != Globals.colors.orange:
			get_parent().add_child(bullet)
		
		bullet.applyColor(bulletColor)
		bullet.launch(shootVector, $"Bullet Spawn".global_position, self.rotation, bulletColor)
		$ShootCD.start()
	
	if Input.is_action_just_pressed("bullet0"):
		bulletColor = Globals.colors.white
		emit_signal("bulletChanged", bulletColor)
	elif Input.is_action_just_pressed("bullet1"):
		bulletColor = Globals.colors.red
		emit_signal("bulletChanged", bulletColor)
	elif Input.is_action_just_pressed("bullet2"):
		bulletColor = Globals.colors.orange
		emit_signal("bulletChanged", bulletColor)
	elif Input.is_action_just_pressed("bullet3"):
		bulletColor = Globals.colors.yellow
		emit_signal("bulletChanged", bulletColor)
	elif Input.is_action_just_pressed("bullet4"):
		bulletColor = Globals.colors.green
		emit_signal("bulletChanged", bulletColor)
	elif Input.is_action_just_pressed("bullet5"):
		bulletColor = Globals.colors.blue
		emit_signal("bulletChanged", bulletColor)
	elif Input.is_action_just_pressed("bullet6"):
		bulletColor = Globals.colors.violet
		emit_signal("bulletChanged", bulletColor)


func _physics_process(delta):
	var moveVector = handleMoveInput()
	applyMovement(moveVector, delta)
		
	if !dashing:
		if Input.is_action_pressed("ui_right"):
			rotation += ROTATION_SPEED * delta
		elif Input.is_action_pressed("ui_left"):
			rotation -= ROTATION_SPEED * delta
		
	shootVector = Vector2(sin(rotation), -cos(rotation))
	
	var speedSquared = velocity.length_squared() 
	if speedSquared > 25:
		flightTrail1.emitting = true
		flightTrail1.lifetime = 0.5 * (speedSquared / pow(MAX_SPEED, 2))
		flightTrail2.emitting = true
		flightTrail2.lifetime = 0.5 * (speedSquared / pow(MAX_SPEED, 2))
		# play flight SFX
	else:
		flightTrail1.emitting = false
		flightTrail2.emitting = false
		# stop playing flight SFX


func handleMoveInput() -> Vector2:
	var moveVector = Vector2.ZERO
	if !dashing:
		if !Globals.mainScene.usingController:
			var inputVector = Vector2(0, -Input.get_action_strength("ui_up"))
			moveVector = inputVector.normalized()
		else:
			var inputVector = Vector2(0, -abs(Input.get_joy_axis(0, JOY_AXIS_1)))
			if inputVector.length() >= GameManager.deadzone0:
				moveVector = inputVector.normalized()
	return moveVector
	

func applyMovement(moveVector, delta):
	if moveVector != Vector2.ZERO:
		velocity.x += moveVector.x * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		velocity.y += moveVector.y * ACCELERATION * delta
		velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)
	
	if Input.is_action_pressed("ui_down"):
		velocity *= FRICTION
		
	var _temp = move_and_slide(transform.basis_xform(velocity), Vector2.UP) # given a variable so the editor stops yelling at me


func startDash():
	dashing = true
	var dashVelocity = Vector2.UP * DASH_SPEED
	$Tween.interpolate_property(self, "velocity", null, dashVelocity, 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()


func endDash():
	dashing = false
	$Tween.interpolate_property(self, "velocity", null, Vector2.ZERO, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	print("dash ended")


func onDeathAnimFinish():
	emit_signal("finishedDeathAnim")
