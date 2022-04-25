extends Control

var heartSize: int = 16


func _on_Player_heart_changed(newHearts):
	$Hearts.rect_size.x = newHearts * heartSize
	print("Heart created")
