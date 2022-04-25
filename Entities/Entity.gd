extends KinematicBody2D
class_name Entity

const FRICTION: float = 0.15

export(int) var accel: int = 50
export(int) var maxSpeed: int = 100


onready var animatedSprite: AnimatedSprite = get_node("AnimatedSprite")
onready var shapeshift = false

var movDirection: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

func move() -> void : 
	movDirection = movDirection.normalized()
	velocity += movDirection * accel
	velocity = velocity.clamped(maxSpeed)
