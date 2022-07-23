extends Node
# manages game entities and data

var bounds: Rect2

# player stuff
var score: int
var playerHP: int = 5 # maybe change based on difficulty later (5/3/1)?


# controller variables
var usingController = false
var deadzone0 = 0.3

func _ready():
	Globals.set("mainScene", self)
	
	var screenSize = Vector2(get_viewport().get_visible_rect().size.x - 10, get_viewport().get_visible_rect().size.y - 10)
	bounds = Rect2(Vector2(10, 10), screenSize)
	

func damagePlayer():
	playerHP -= 1
	if playerHP <= 0:
		endGame()


func endGame():
	print("you lose!")
	pass


# teleports player when they reach the end of the screen
func _on_Area_Bounds_body_exited(body):
	if body.position.x <= 10:
		body.position = Vector2(bounds.size.x, body.position.y)
	elif body.position.x >= bounds.size.x:
		body.position = Vector2(0, body.position.y)
	elif body.position.y <= 10:
		body.position = Vector2(body.position.x, bounds.size.y)
	elif body.position.y >= bounds.size.y:
		body.position = Vector2(body.position.x, 0)


func _on_Area_Bounds_area_exited(area):
	if area.position.x <= 10:
		area.position = Vector2(bounds.size.x, area.position.y)
	elif area.position.x >= bounds.size.x:
		area.position = Vector2(0, area.position.y)
	elif area.position.y <= 10:
		area.position = Vector2(area.position.x, bounds.size.y)
	elif area.position.y >= bounds.size.y:
		area.position = Vector2(area.position.x, 0)
