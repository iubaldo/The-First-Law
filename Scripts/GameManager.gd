extends Node

var bounds: Rect2

# player stuff
var score: int
var hp: int


# controller variables
var usingController = false
var deadzone0 = 0.3

func _ready():
	var screenSize = Vector2(get_viewport().get_visible_rect().size.x, get_viewport().get_visible_rect().size.y)
	bounds = Rect2(Vector2(0, 0), screenSize)


# teleports entities when they reach the end of the screen
func _on_Area_Bounds_body_exited(body):
	if body.position.x <= 0:
		body.position = Vector2(bounds.size.x, body.position.y)
	elif body.position.x >= bounds.size.x:
		body.position = Vector2(0, body.position.y)
	elif body.position.y <= 5:
		body.position = Vector2(body.position.x, bounds.size.y)
	elif body.position.y >= bounds.size.y:
		body.position = Vector2(body.position.x, 0)
