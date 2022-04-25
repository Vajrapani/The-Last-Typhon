extends Node


var enemiesRemaining: int = 1

func _ready():
	var enemiesRemaining: int = self.get_child_count()

func _process(delta):
	var enemiesRemaining: int = self.get_child_count()
	if enemiesRemaining <= 0:
		get_tree().change_scene("res://Game4.tscn")
