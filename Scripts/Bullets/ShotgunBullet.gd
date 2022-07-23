extends Bullet
class_name ShotgunBullet

func onLaunch(vec: Vector2, pos: Vector2, rot: float, clr: int): 
	var bulletInst1 = Globals.basicBulletTemplate.instance()
	pass


func rotateVector(vec : Vector2, delta : float):
	return Vector2(vec.x * cos(delta) - vec.y * sin(delta), vec.x * sin(delta) + vec.y * cos(delta))
