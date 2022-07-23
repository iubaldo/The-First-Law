extends Node
# manages game entities and data

var bounds: Rect2

# player stuff
var score: int
var hp: int


# controller variables
var usingController = false
var deadzone0 = 0.3

func _ready():
	var screenSize = Vector2(get_viewport().get_visible_rect().size.x - 10, get_viewport().get_visible_rect().size.y - 10)
	bounds = Rect2(Vector2(10, 10), screenSize)


# teleports entities when they reach the end of the screen
func _on_Area_Bounds_body_exited(body):
	if body.position.x <= 10:
		body.position = Vector2(bounds.size.x, body.position.y)
	elif body.position.x >= bounds.size.x:
		body.position = Vector2(0, body.position.y)
	elif body.position.y <= 10:
		body.position = Vector2(body.position.x, bounds.size.y)
	elif body.position.y >= bounds.size.y:
		body.position = Vector2(body.position.x, 0)
