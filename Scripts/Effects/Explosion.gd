extends Particles2D


func start():
	$SFX.play()
	emitting = true
	$"Destroy Timer".start()


func _on_Destroy_Timer_timeout():
	queue_free()
