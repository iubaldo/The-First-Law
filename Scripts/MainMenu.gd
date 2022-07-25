extends Node2D


func _ready():
	$AnimationPlayer.play("MainMenuAnimation")


func _on_Start_Button_button_down():
	$"UI Elements/VBoxContainer/Start Button/StartSound".play()


func _on_Controls_Button_button_down():
	$"UI Elements/VBoxContainer/Controls Button/ControlsSound".play()
	$ControlsPage.visible = true


func _on_Quit_Button_button_down():
	$"UI Elements/VBoxContainer/Quit Button/QuitSound".play()


func _on_StartSound_finished():
	get_tree().change_scene("res://Scenes/Main Scene.tscn")
	

func _on_QuitSound_finished():
	get_tree().quit()


func _on_Control_Page_Button_button_down():
	$"UI Elements/VBoxContainer/Controls Button/ControlsSound".play()
	$ControlsPage.visible = false
