extends Entity

onready var isAttacking = false
onready var animplayer: AnimationPlayer = get_node("AnimationPlayer")
onready var daggerAnim: AnimationPlayer = get_node("Dagger/DaggerAnim")
onready var dagger: Area2D = get_node("Dagger")
onready var comboBar: ProgressBar = get_tree().current_scene.get_node("comboBar")
onready var shapeshiftTimer = $ShapeshiftTimer

var maxHearts: int = 4
var currentHearts: float = 4.0
signal heart_changed(newHearts)

var extraDamage: int = 0
func _ready():
	connect("heart_changed", get_parent().get_node("HealthUI"), "on_player_heart_changed")
	emit_signal("heart_changed", maxHearts)

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	if mouse_direction.x > 0 and animatedSprite.flip_h:
		animatedSprite.flip_h = false

	elif mouse_direction.x < 0 and not animatedSprite.flip_h:
		animatedSprite.flip_h = true
	
	
	
	dagger.rotation = mouse_direction.angle()
	if dagger.scale.y == 1 and mouse_direction.x < 0:
		dagger.scale.y = -1
	elif dagger.scale.y == -1  and mouse_direction.x > 0:
		dagger.scale.y = 1
	

func get_input() -> void:
	movDirection = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		movDirection += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		movDirection += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		movDirection += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		movDirection += Vector2.UP
	if Input.is_action_just_pressed("ui_transform") and $ComboUI.currentCombo == 4 and shapeshift == false:
		shapeshift = !shapeshift
		$Dagger.currentCombo -= 4
		$Dagger.emit_signal("combo_changed", $Dagger.currentCombo)
		shapeshiftTimer.start()
	if Input.is_action_just_pressed("ui_attack"):
		if shapeshift == false:
			daggerAnim.play("Swing 1")
		elif shapeshift == true :
			daggerAnim.play("Swing 2")
	if Input.is_action_just_pressed("ui_heal")and $ComboUI.currentCombo >= 1 and currentHearts < 4:
		currentHearts += 1
		emit_signal("heart_changed", currentHearts)
		$Dagger.currentCombo -= 1
		$Dagger.emit_signal("combo_changed", $Dagger.currentCombo)

func _on_ShapeshiftTimer_timeout():
	if shapeshift == true:
		shapeshift = !shapeshift
		
func handle_hit(damage : int):
	currentHearts -= damage
	print("Your HP is now :  " + str(currentHearts))
	emit_signal("heart_changed", currentHearts)
	if currentHearts <= 0:
		get_tree().change_scene("res://Interface Scenes/Death.tscn")
