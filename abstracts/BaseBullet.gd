extends Area2D
class_name BaseBullet

signal entityHit(entity: BaseEntity)

class BaseAI:
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
@export var impact: float = 1
@export var recoil: float = 1

var spawnPosition: Vector2
var spawnTime: float
var currentPenetrated: int = 0
var launcher: BaseEntity
var ais: Array[BaseAI] = []
var energyInjected: float = 10

func _ready() -> void:
	spawnPosition = position
	spawnTime = TimeUtil.current()
	ais = getAI()
func _physics_process(delta: float) -> void:
	if isLiving():
		for composedAI in ais:
			composedAI.physics(self, delta)
	else:
		queue_free()

func hitEntity(entity: BaseEntity) -> bool:
	match GameRuleManager.judgeCirt(launcher, getBaseDamage()):
		[ var state, var dmg]:
			DamageSource.new(launcher, dmg, state, entity).apply()
	entityHit.emit(entity)
	entity.impact(GameRuleManager.impactVector(Vector2.from_angle(rotation), impact))
	return true

func getBaseDamage() -> float:
	if launcher is BaseLiving:
		return launcher.getStat(Stats.Living.ATTACK_POWER) * launcher.getStat(Stats.Living.ATTACK_FACTOR) * GameRuleManager.energyMapDamage(energyInjected) * damageFactor
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
