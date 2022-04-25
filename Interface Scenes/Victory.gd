extends CanvasLayer
var perimeter_size := Vector2(482,482)
func _ready():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, perimeter_size)
	OS.set_window_size(2 * perimeter_size)

