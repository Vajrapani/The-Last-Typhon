extends Area2D

onready var daggerCollide: CollisionShape2D = get_node("daggerCollider")
export (int) var damage := 2
var maxCombo: int = 4
var currentCombo: float = 0.0
onready var parent: Entity = get_parent()
signal combo_changed(newCombo)
# Called when the node enters the scene tree for the first time.
func _ready():
	daggerCollide.disabled = true
	connect("combo_changed", get_tree().current_scene.get_node("ComboUI"), "on_player_combo_changed")
	emit_signal("combo_changed", currentCombo)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta)s
#	pass


func _on_Dagger_body_entered(body : Node) -> void:
	if body.has_method("handle_hit"):
		body.handle_hit(damage + parent.extraDamage)
		if currentCombo < 4:
			currentCombo += 1
		emit_signal("combo_changed", currentCombo)
