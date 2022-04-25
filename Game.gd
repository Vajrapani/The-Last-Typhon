extends Node2D
class_name Game

signal started
signal finished

var _rng := RandomNumberGenerator.new()

export var perimeter_size := Vector2(1,1)

onready var _tile_map : TileMap = get_node("Navigation2D/TileMap")

var size := 2 * perimeter_size

var topleft = [6] 
var topright = [7, 8, 9]
var bottomleft = [0, 1 , 2]
var bottomright = [3] 

func _ready() -> void:
	
	var map_size_px := size * _tile_map.cell_size
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, map_size_px)
	OS.set_window_size(2 * map_size_px)
	generate()
	
	
func generate() -> void:
	emit_signal("started")
	generate_boxes()
	emit_signal("finished")
	
func generate_boxes() -> void:
	
	_rng.randomize()
	for x in [0, size.x - 1]:
		for y in range(0, size.y):
			if x == 0 && y == 0:
				_tile_map.set_cell(x, y, topleft[_rng.randi_range(0, 0)])
			elif x == 1 && y == 0:
				_tile_map.set_cell(x, y , topright[_rng.randi_range(0, 1)])
			elif x == 0 && y == 1:
				_tile_map.set_cell(x, y , bottomleft[_rng.randi_range(0, 2)])
			elif x == 1 && y == 1:
				_tile_map.set_cell(x, y , bottomright[_rng.randi_range(0, 0)])



