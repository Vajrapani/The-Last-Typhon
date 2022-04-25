
extends FiniteStateMachine

func _init() -> void:
	_add_state("idle")
	_add_state("move")
	_add_state("shapeshift_idle")
	_add_state("shapeshift_move")
	
func _ready() -> void:
	set_state(states.idle)

func _state_logic(_delta: float) -> void:
	parent.get_input()
	parent.move()

func _get_transition() -> int:
	match state:
		states.shapeshift_idle:
			if parent.velocity.length() > 10 and parent.shapeshift == true:
				return states.shapeshift_move
			elif parent.velocity.length() < 10 and parent.shapeshift == false:
				return states.idle
			elif parent.velocity.length() > 10 and parent.shapeshift == false:
				return states.move

		states.shapeshift_move:
			if parent.velocity.length() < 10 and parent.shapeshift == true:
				return states.shapeshift_idle
			elif parent.velocity.length() > 10 and parent.shapeshift == false:
				return states.move
			elif parent.velocity.length() < 10 and parent.shapeshift == false:
				return states.idle

		states.idle:
			if parent.velocity.length() > 10 and parent.shapeshift == false:
				return states.move
			elif parent.velocity.length() < 10 and parent.shapeshift == true:
				return states.shapeshift_idle
			elif parent.velocity.length() > 10 and parent.shapeshift == true:
				return states.shapeshift_move

		states.move:
			if parent.velocity.length() < 10 and parent.shapeshift == false:
				return states.idle
			elif parent.velocity.length() > 10 and parent.shapeshift == true:
				return states.shapeshift_move
			elif parent.velocity.length() < 10 and parent.shapeshift == true:
				return states.shapeshift_idle
	return -1

func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.idle:
			animation_player.play("Idle")
			parent.accel = 50
			parent.maxSpeed = 100
			parent.extraDamage = 0
		states.move:
			animation_player.play("Run")
			parent.accel = 50
			parent.maxSpeed = 100
			parent.extraDamage = 0
		states.shapeshift_idle:
			animation_player.play("Shapeshift_Idle")
			parent.accel = 100
			parent.maxSpeed = 200
			parent.extraDamage = 4
		states.shapeshift_move:
			animation_player.play("Shapeshift_Run")
			parent.accel = 100
			parent.maxSpeed = 200
			parent.extraDamage = 4
