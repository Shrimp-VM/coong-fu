extends Area2D
class_name BaseBullet

class BaseAI extends Resource:
	func run(bullet: BaseBullet):
		return bullet
	func physics(bullet: BaseBullet, delta: float):
		return [bullet, delta]

@export var lifeDistance: float = INF
@export var lifeTime: float = INF
@export var baseMovement: float = 100
@export var defaultDamage: float = 10
@export var damageFactor: float = 1
@export var stats: Dictionary[Stats.Bullet, float] = {
	Stats.Bullet.PENETRATE: 0
}

var spawnPosition: Vector2
var spawnTime: float
var currentPenetrated: int = 0
var launcher: BaseEntity
var ais: Array[BaseAI] = []

func _ready() -> void:
	spawnPosition = position
	spawnTime = TimeUtil.current()
func _physics_process(delta: float) -> void:
	if isLiving():
		for ai in ShrimpVMUtil.concat_array(ais, getAI()):
			if ai is BaseAI:
				ai.physics(self, delta)
	else:
		queue_free()

func hitEntity(entity: BaseEntity) -> bool:
	match GameRuleManager.judgeCirt(launcher, getBaseDamage()):
		[ var state, var dmg]:
			DamageSource.new(launcher, dmg, state, entity).apply()
	return true

func getBaseDamage() -> float:
	if launcher is BaseLiving:
		return launcher.getStat(Stats.Living.ATTACK_POWER) * launcher.getStat(Stats.Living.ATTACK_FACTOR) * damageFactor
	else:
		return defaultDamage * damageFactor
func getAI() -> Array[BaseAI]:
	return []
func setStat(key: Stats.Bullet, value: float):
	stats.set(key, value)
func getStat(key: Stats.Bullet) -> float:
	return stats.get(key, 0)
func isLiving() -> bool:
	return (
		position.distance_to(spawnPosition) < lifeDistance &&
		TimeUtil.current() - spawnTime < lifeTime &&
		!isFullPenetrated()
	)
func isFullPenetrated() -> bool:
	return currentPenetrated > getStat(Stats.Bullet.PENETRATE)
