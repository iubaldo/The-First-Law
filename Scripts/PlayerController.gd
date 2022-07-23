extends KinematicBody2D
class_name Player
# handles player controls


#preloads
onready var bulletTemplate = preload("res://Scenes/Bullet.tscn")


# movement variables
var velocity: Vector2
const ACCELERATION = 20 * 32
const MAX_SPEED = 16 * 32
const FRICTION = 0.95
const ROTATION_SPEED = 5


func _input(event):
	if Input.is_action_just_pressed("shoot"):
		var bullet = bulletTemplate.instance()
		get_parent().add_child(bullet)
		bullet.position = self.position


func _physics_process(delta):
	var moveVector = handleMoveInput()
	applyMovement(moveVector, delta)
	
	if Input.is_action_pressed("rotate_cw"):
		rotation += ROTATION_SPEED * delta
	elif Input.is_action_pressed("rotate_ccw"):
		rotation -= ROTATION_SPEED * delta


func handleMoveInput() -> Vector2:
	var moveVector = Vector2.ZERO
	if !GameManager.usingController:
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
		
	move_and_slide(transform.basis_xform(velocity), Vector2.UP)
