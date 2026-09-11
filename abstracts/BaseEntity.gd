extends CharacterBody2D
class_name BaseEntity

signal healthChanged(new: float, old: float)
signal damageTaken(dmg: DamageSource)

@export var currentHealth: float = 100
@export var baseMovement: float = 20
@export var fraction: float = 10

@onready var anchorParent: Node2D = $%anchors
@onready var hurtboxArea: Area2D = $%hurtbox

func _ready() -> void:
	hurtboxArea.area_entered.connect(
		func(body):
			if body is BaseBullet:
				GameRuleManager.bulletHitEntity(body, self)
	)
	spawn()
func _physics_process(delta: float) -> void:
	ai(delta)
	move_and_slide()
	velocity *= 1 - fraction * delta

func accelerationFactor() -> float:
	return 1
func spawn():
	pass
func ai(delta: float):
	return delta

func setHealth(newHealth: float):
	healthChanged.emit(newHealth, currentHealth)
	currentHealth = newHealth
func applyDamage(dmg: DamageSource):
	damageTaken.emit(dmg)
	setHealth(currentHealth - dmg.amount)
func accelerate(direction: Vector2, delta: float, maxSpeed: float) -> Vector2:
	velocity = (velocity + direction.normalized() * baseMovement * 200 * accelerationFactor() * delta).limit_length(maxSpeed)
	return velocity
func isPlayer() -> bool:
	assert(false, "未实现")
	return false
func getAnchor(namx: String) -> Vector2:
	var anchor = anchorParent.get_node(namx)
	if anchor is Node2D:
		return anchor.global_position
	else:
		return Vector2.ZERO
