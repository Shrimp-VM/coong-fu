extends CharacterBody2D
class_name BaseEntity

@export var currentHealth: float = 100
@export var baseMovement: float = 4000
@export var fraction: float = 10

func _ready() -> void:
	spawn()
func _physics_process(delta: float) -> void:
	ai(delta)
	move_and_slide()
	velocity *= 1 - fraction * delta

func spawn():
	pass
func ai(delta: float):
	return delta

func accelerate(direction: Vector2, delta: float, maxSpeed: float) -> Vector2:
	velocity = (velocity + direction.normalized() * baseMovement * delta).limit_length(maxSpeed)
	return velocity
func isPlayer() -> bool:
	assert(false, "未实现")
	return false
