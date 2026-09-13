extends Area2D
class_name BaseBullet

signal entityHit(entity: BaseEntity)

class BaseAI:
	func config(_bullet: BaseBullet):
		pass
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
@export var recoil: float = 0

var spawnPosition: Vector2
var spawnTime: float
var currentPenetrated: int = 0
var launcher: BaseEntity
var ais: Array[BaseAI] = []
var energyInjected: float = 10
var dieing: bool = false

func _ready() -> void:
	spawnPosition = position
	spawnTime = TimeUtil.current()
	ais = getAI()
	for ai in ais:
		ai.config(self)
func _physics_process(delta: float) -> void:
	if isLiving():
		for composedAI in ais:
			composedAI.physics(self, delta)
	else:
		enterDie()

func hitEntity(entity: BaseEntity) -> bool:
	if !is_instance_valid(launcher): return true
	match GameRuleManager.judgeCirt(launcher, getBaseDamage()):
		[ var state, var dmg]:
			DamageSource.new(launcher, dmg, state, entity).apply()
	entityHit.emit(entity)
	entity.impact(GameRuleManager.impactVector(Vector2.from_angle(rotation), impact))
	return true
func die():
	pass

func enterDie():
	if dieing: return
	dieing = true
	await die()
	dieing = false
	queue_free()
func getBaseDamage() -> float:
	if !is_instance_valid(launcher): return 0
	if launcher is BaseLiving:
		return launcher.getBaseDamage() * GameRuleManager.energyMapDamage(energyInjected) * damageFactor
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
		is_instance_valid(launcher) &&
		distanceTraveled() < lifeDistance &&
		timeLived() < lifeTime &&
		!isFullPenetrated() &&
		!dieing
	)
func isFullPenetrated() -> bool:
	return currentPenetrated > getStat(Stats.Bullet.PENETRATE)
func timeLived() -> float:
	return TimeUtil.current() - spawnTime
func distanceTraveled() -> float:
	return position.distance_to(spawnPosition)
