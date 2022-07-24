extends Bullet
class_name Blade


func handleMovement(delta):
	pass


func launch(vec: Vector2, pos: Vector2, rot: float, clr: int):
	$AnimationPlayer.play("BladeAnimation")


func _on_Blade_area_entered(area):
	if area.is_in_group("asteroid") && \
		(color == area.color || color == Globals.colors.white || area.color == Globals.colors.white):
		area.velocity *= -1.5
		area.destroy()
	elif area.is_in_group("bullet"):
		area.queue_free()
