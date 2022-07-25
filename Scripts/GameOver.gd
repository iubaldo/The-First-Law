extends Node2D


func _ready():
	$AnimationPlayer.play("MainMenuAnimation")
	$"UI Elements/Title2".text = "final score:\n" + var2str(Globals.finalScore)


func _on_Start_Button_button_down():
	$"UI Elements/VBoxContainer/Start Button/StartSound".play()



func _on_Quit_Button_button_down():
	$"UI Elements/VBoxContainer/Quit Button/QuitSound".play()


func _on_StartSound_finished():
	get_tree().change_scene("res://Scenes/Main Scene.tscn")
	

func _on_QuitSound_finished():
	get_tree().quit()

