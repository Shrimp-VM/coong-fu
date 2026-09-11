extends BaseEntity
class_name BaseLiving

@export var stats: Dictionary[Stats.Living, float] = {
	Stats.Living.MAX_HEALTH: 500,
	Stats.Living.ATTACK_POWER: 100,
	Stats.Living.MOVEMENT_FACTOR: 1,
	Stats.Living.OFFSET_SHOOT: 0,
	Stats.Living.ATTACK_FACTOR: 1,
	Stats.Living.CRIT_RATE: 0.05,
	Stats.Living.CRIT_DAMAGE: 1
}
@export var attackGap: float = 500

@onready var stateBar: StateBar = $%stateBar
var attackCooldown: CooldownController

func _ready() -> void:
	super._ready()
	attackCooldown = CooldownController.new(attackGap)

func accelerationFactor() -> float:
	return getStat(Stats.Living.MOVEMENT_FACTOR)

func setStat(key: Stats.Living, value: float):
	stats.set(key, value)
func getStat(key: Stats.Living) -> float:
	return stats.get(key, 0)
