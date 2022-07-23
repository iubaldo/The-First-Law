extends KinematicBody2D
class_name Bullet
# abstract class that defines bullet behavior


var velocity = Vector2.ZERO



# hit the player
func _on_Bullet_body_entered(body):
	pass # Replace with function body.


#hit an asteroid or another bullet
func _on_Bullet_area_entered(area):
	
	pass # Replace with function body.
