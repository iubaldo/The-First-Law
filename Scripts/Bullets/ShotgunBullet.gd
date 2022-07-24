extends Bullet
class_name ShotgunBullet
# fires multiple bullets in a cone

func onLaunch(vec: Vector2, pos: Vector2, rot: float, clr: int): 
	#var bulletInst1 = Globals.basicBulletTemplate.instance()
	var bulletInst2 = Globals.basicBulletTemplate.instance()
	#var bulletInst3 = Globals.basicBulletTemplate.instance()
	var bulletInst4 = Globals.basicBulletTemplate.instance()
	
	#Globals.mainScene.get_node("Entities").add_child(bulletInst1)
	Globals.mainScene.get_node("Entities").add_child(bulletInst2)
	#Globals.mainScene.get_node("Entities").add_child(bulletInst3)
	Globals.mainScene.get_node("Entities").add_child(bulletInst4)
	
	bulletInst2.applyColor(color)
	bulletInst4.applyColor(color)
	
	#bulletInst1.launch(rotateVector(vec, deg2rad(5)), pos, rot + deg2rad(5), clr)
	bulletInst2.launch(rotateVector(vec, deg2rad(10)), pos, rot + deg2rad(10), clr)
	#bulletInst3.launch(rotateVector(vec, deg2rad(-5)), pos, rot + deg2rad(-5), clr)
	bulletInst4.launch(rotateVector(vec, deg2rad(-10)), pos, rot + deg2rad(-10), clr)


func rotateVector(vec : Vector2, delta : float):
	return Vector2(vec.x * cos(delta) - vec.y * sin(delta), vec.x * sin(delta) + vec.y * cos(delta))
