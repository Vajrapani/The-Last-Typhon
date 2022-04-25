extends Entity

export (int) var health := 50

var path: PoolVector2Array

onready var navigation: Navigation2D = get_tree().current_scene.get_node("Navigation2D")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var path_timer: Timer = get_node("PathTimer")
onready var animplayer: AnimationPlayer = get_node("AnimationPlayer")
onready var bomb: Area2D = get_node("Bomb")
onready var foundPlayer = false
export (int) var damage := 3

func _ready():
	accel = 80
	maxSpeed = 80

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
		if distance_to_next_point <= 25:
			path.remove(0)
			if not path:
				foundPlayer = true
		movDirection = vector_to_next_point
		if vector_to_next_point.x > 0 and bomb.scale.x == -1:
			bomb.scale.x = 1 # left to right
		elif vector_to_next_point.x < 0 and bomb.scale.x == 1:
			bomb.scale.x = -1 # right to left


func _on_PathTimer_timeout():
	if is_instance_valid(player):
		_get_path_to_player()
		foundPlayer = false
	else:
		path_timer.stop()
		path = []
		movDirection = Vector2.ZERO


func _get_path_to_player() -> void:
	path = navigation.get_simple_path(global_position, player.position)




func _on_Bomb_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit(damage)

