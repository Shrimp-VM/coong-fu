extends CharacterBody2D
class_name BaseEntity

@export var currentHealth: float = 100

func _physics_process(delta: float) -> void:
	ai(delta)

func ai(_delta: float):
	pass

func isPlayer() -> bool:
	assert(false, "未实现")
	return false
