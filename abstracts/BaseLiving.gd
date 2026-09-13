extends BaseEntity
class_name BaseLiving

class BaseAI:
	func run(living: BaseLiving):
		return living
	func physics(living: BaseLiving, delta: float):
		return [living, delta]

@export var attackGap: float = 500

@onready var stateBar: StateBar = $%stateBar
@onready var hook: HookController = $%hook
var attackCooldowns: Dictionary[int, CooldownController] = {
	0: CooldownController.new(0)
}
var attackings: Array[int] = []
var stats: Dictionary[Stats.Living, float] = {
	Stats.Living.MAX_HEALTH: 500,
	Stats.Living.ATTACK_POWER: 100,
	Stats.Living.MOVEMENT_FACTOR: 1,
	Stats.Living.OFFSET_SHOOT: 0,
	Stats.Living.ATTACK_FACTOR: 1,
	Stats.Living.CRIT_RATE: 0.05,
	Stats.Living.CRIT_DAMAGE: 1,
	Stats.Living.ANTI_IMPACT: 0,
	Stats.Living.ATTRACTION_WEIGHT: 100,
	Stats.Living.ATTACK_SPEED: 1
}
var energyInjected: float = 10
var dashing: bool = false
var dashCooldown: CooldownController = CooldownController.new(500)
var ais: Array[BaseAI] = []
var focusingEntity: BaseEntity = null

func _ready() -> void:
	super._ready()
	healthChanged.connect(
		func(new, _o):
			stateBar.healthBar.setCurrent(new)
	)
	applyMaxHealth()
	ais = getAI()

func ai(delta: float):
	for composedAI in ais:
		composedAI.physics(self, delta)
func accelerationFactor() -> float:
	return getStat(Stats.Living.MOVEMENT_FACTOR)
func attack(type: int):
	match type:
		0:
			pass
func getAI() -> Array[BaseAI]:
	return []

func getBaseDamage() -> float:
	return getStat(Stats.Living.ATTACK_POWER) * getStat(Stats.Living.ATTACK_FACTOR)
func dash(force: Vector2):
	if !dashCooldown.flag(): return
	dashing = true
	dashCooldown.lock()
	impact(force)
	while velocity.length() >= baseMovement * 10:
		await get_tree().process_frame
	dashCooldown.unlock()
	dashing = false
func impact(force: Vector2):
	return super.impact(force / (1 + getStat(Stats.Living.ANTI_IMPACT)))
func enterAttack(type: int):
	if type in attackings: return
	attackCooldowns[type].cooldownSpeed = getStat(Stats.Living.ATTACK_SPEED)
	if !attackCooldowns[type].flag(): return
	attackings.append(type)
	hook.callEvent(HookController.EventName.onLivingAttack, [self, type])
	await attack(type)
	attackings.erase(type)
func applyMaxHealth():
	stateBar.healthBar.maxValue = getStat(Stats.Living.MAX_HEALTH)
	stateBar.healthBar.fillTo(getStat(Stats.Living.MAX_HEALTH))
	setHealth(getStat(Stats.Living.MAX_HEALTH))
func setHealth(newHealth: float):
	super.setHealth(clamp(newHealth, 0, getStat(Stats.Living.MAX_HEALTH)))
func setStat(key: Stats.Living, value: float):
	stats.set(key, value)
func getStat(key: Stats.Living) -> float:
	if key == Stats.Living.ATTACK_SPEED:
		if isPlayer():
			pass
	return (
		ValueModifier
			.fromChain(hook.callEvent(HookController.EventName.getLivingStatsModifiers, [self]).map(func(e: Dictionary): return e.get(key)))
			.modify(stats.get(key, 0))
	)
func distanceToFocusing() -> float:
	if is_instance_valid(focusingEntity):
		return position.distance_to(focusingEntity.position)
	else:
		return INF
func rotationToFocusing() -> float:
	if is_instance_valid(focusingEntity):
		return position.angle_to_point(focusingEntity.position)
	else:
		return 0
func isInvincible() -> bool:
	return dashing || super.isInvincible()
