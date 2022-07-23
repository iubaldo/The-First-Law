extends Node

enum colors { red, orange, yellow, green, blue, violet, white }

onready var asteroid01 = preload("res://Scenes/Asteroids/Asteroid 0-1.tscn")
onready var asteroid02 = preload("res://Scenes/Asteroids/Asteroid 0-2.tscn")
onready var asteroid03 = preload("res://Scenes/Asteroids/Asteroid 0-3.tscn")
onready var asteroid11 = preload("res://Scenes/Asteroids/Asteroid 1-1.tscn")
onready var asteroid12 = preload("res://Scenes/Asteroids/Asteroid 1-2.tscn")
onready var asteroid13 = preload("res://Scenes/Asteroids/Asteroid 1-3.tscn")
onready var asteroid21 = preload("res://Scenes/Asteroids/Asteroid 2-1.tscn")
onready var asteroid22 = preload("res://Scenes/Asteroids/Asteroid 2-2.tscn")
onready var asteroid23 = preload("res://Scenes/Asteroids/Asteroid 2-3.tscn")

onready var basicBulletTemplate = preload("res://Scenes/Bullets/BasicBullet.tscn")
onready var shotgunBulletTemplate = preload("res://Scenes/Bullets/ShotgunBullet.tscn")
onready var gravityBulletTemplate = preload("res://Scenes/Bullets/GravityBullet.tscn")

var mainScene
