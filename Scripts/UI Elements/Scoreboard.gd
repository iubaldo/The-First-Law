extends Node2D
class_name ScoreBoard

onready var scoreLabel = $Label


func _ready():
	Globals.set("scoreboard", self)


func updateScoreboard(newScore: int):
	scoreLabel.text = var2str(newScore)
