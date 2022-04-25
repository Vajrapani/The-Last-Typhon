extends Control

var comboSize: int = 16
var currentCombo: int = 0

func _on_Dagger_combo_changed(newCombo):
	$Combo.rect_size.x = newCombo * comboSize
	currentCombo = newCombo
	print("combo created")
