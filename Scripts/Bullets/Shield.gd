extends Bullet
class_name Shield


func handleMovement(delta):
	pass


func launch(vec: Vector2, pos: Vector2, rot: float, clr: int):
	$AnimationPlayer.play("ShieldAnimation")


func startDash():
	Globals.player.startDash()


func endDash():
	Globals.player.endDash()


func _on_Shield_area_entered(area):
	if area.is_in_group("asteroid") && \
		(color == area.color || color == Globals.colors.white || area.color == Globals.colors.white):
		area.velocity *= -2
		area.destroy()
	elif area.is_in_group("bullet"):
		area.queue_free()
