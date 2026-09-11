extends Area2D
class_name BaseBullet

class BaseAI extends Resource:
	func run(bullet: BaseBullet):
		return bullet
	func physics(bullet: BaseBullet, delta: float):
		return [bullet, delta]

@export var baseMovement: float = 100
@export var defaultDamage: float = 10
@export var damageFactor: float = 1

var launcher: BaseEntity
var ais: Array[BaseAI] = []

func _physics_process(delta: float) -> void:
	for ai in ShrimpVMUtil.concat_array(ais, getAI()):
		if ai is BaseAI:
			ai.physics(self, delta)

func hitEntity(entity: BaseEntity):
	return DamageSource.new(launcher, getBaseDamage(), false, entity).apply()

func getBaseDamage() -> float:
	if launcher is BaseLiving:
		return launcher.getStat(Stats.Living.ATTACK_POWER) * launcher.getStat(Stats.Living.ATTACK_FACTOR) * damageFactor
	else:
		return defaultDamage * damageFactor
func getAI() -> Array[BaseAI]:
	return []
