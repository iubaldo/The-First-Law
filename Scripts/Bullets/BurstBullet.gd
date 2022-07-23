extends Bullet
class_name BurstBullet
# fires multiple bullets in sequence

var burstAmount = 2


func onLaunch(vec : Vector2, pos : Vector2, rot : float, clr: int):
	$"Burst Timer".start()


func _on_Burst_Timer_timeout():
	if burstAmount > 0:
		burstAmount -= 1
		
		var bulletInst = Globals.basicBulletTemplate.instance()
		Globals.mainScene.get_node("Entities").add_child(bulletInst)
		bulletInst.launch(Globals.player.shootVector, Globals.player.get_node("Bullet Spawn").global_position,
			Globals.player.rotation, color)
		
		$"Burst Timer".start()
