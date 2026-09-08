extends BaseEntity
class_name BaseLiving

@export var stats: Dictionary[Stats.Living, float] = {
	Stats.Living.MAX_HEALTH: 100,
	Stats.Living.ATTACK_POWER: 100,
	Stats.Living.MOVEMENT_FACTOR: 1
}
