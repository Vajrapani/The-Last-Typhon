extends FiniteStateMachine


func _init() -> void:
	_add_state("chase")
	_add_state("attack")

func _ready() -> void:
	set_state(states.chase)

func _state_logic(_delta: float) -> void:
	if state == states.chase:
		parent.chase()
		parent.move()

func _get_transition() -> int:
	match state:
		states.chase:
			if parent.foundPlayer == true:
				return states.attack
		states.attack:
			if parent.foundPlayer == false:
				return states.chase
	return -1
	
func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.chase:
			animation_player.play("Run")
		states.attack:
			animation_player.play("Attack")
		
