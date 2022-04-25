extends Entity

export (int) var health := 4

var path: PoolVector2Array

onready var navigation: Navigation2D = get_tree().current_scene.get_node("Navigation2D")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var path_timer: Timer = get_node("PathTimer")
onready var animplayer: AnimationPlayer = get_node("AnimationPlayer")
onready var barb: Area2D = get_node("Barb")
onready var foundPlayer = false
export (int) var damage := 2

func _ready():
	accel = 100
	maxSpeed = 150

func handle_hit(damage : int):
	health -= damage
	print("Enemy was Hit! HP : " + str(health))
	if health <= 0:
		queue_free()
		print("Enemy dead!")
		
func chase() -> void:
	if path:
		foundPlayer = false
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		if distance_to_next_point <= 15:
			path.remove(0)
			if not path:
				foundPlayer = true
		movDirection = vector_to_next_point
		
		if vector_to_next_point.x > 0 and barb.scale.x == -1:
			barb.scale.x = 1 # left to right
		elif vector_to_next_point.x < 0 and barb.scale.x == 1:
			barb.scale.x = -1 # right to left
		
#		if vector_to_next_point.x < 0 and vector_to_next_point.y < 0 :
#			foundPlayer = true
		


func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		_get_path_to_player()
		foundPlayer = false
	else:
		path_timer.stop()
		path = []
		movDirection = Vector2.ZERO

func _get_path_to_player() -> void:
	path = navigation.get_simple_path(global_position, player.position)


func _on_Barb_body_entered(body : Node) -> void:
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
