extends Bullet
class_name MissileBullet
# fires a a slow-moving bullet that explodes on impact

func _ready():
	speed = 10 * 32


func onHit(target):
	velocity = Vector2.ZERO
	$MissileExplosion.start()
	$DestroyTimer.start()
	$CollisionPolygon2D.set_deferred("disabled", true)
	$ExplosionCollider/CollisionShape2D.set_deferred("disabled", false)
	$"Flight Trail".emitting = false
	$Sprite.visible = false


func _on_ExplosionCollider_area_entered(area):
	if area.is_in_group("asteroid"):
		if color == area.color || color == Globals.colors.white || area.color == Globals.colors.white:
			area.destroy()


func _on_ExplosionCollider_body_entered(body):
	if body.is_in_group("player"):
		Globals.mainScene.damagePlayer()


func _on_DestroyTimer_timeout():
	queue_free()
