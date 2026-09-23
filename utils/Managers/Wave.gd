extends Node
class_name WaveManager

class EntityWrapper:
	var entity: String
	var maxCount: int
	var isBoss: bool
	var waveRange: Vector2

	func _init(entitx: String, isBosx: bool = false, maxCounx: int = 10, waveRangx: Vector2 = Vector2(0, INF)) -> void:
		entity = entitx
		isBoss = isBosx
		maxCount = 1 if isBoss else maxCounx
		waveRange = waveRangx
	
	func shouldNext() -> bool:
		if WaveManager.current() < waveRange.x || WaveManager.current() > waveRange.y: return false
		if ObjectManager.getEnemyCount("%sEnemy" % entity) >= maxCount: return false
		return true

static var instance: WaveManager

var WAVES: Array[EntityWrapper] = [
	EntityWrapper.new("Hen", false, 30),
	EntityWrapper.new("Chick", false, 1)
]
var currentWave: int = 0
var autoDetect: bool = true
var detectCooldown: CooldownController = CooldownController.new(1000)

func _ready() -> void:
	instance = self
func _physics_process(_delta: float) -> void:
	detectNext()

static func current() -> int:
	return instance.currentWave
static func detectNext():
	if !instance.detectCooldown.flag(): return
	var spawned = false
	for wave in instance.WAVES:
		if wave.shouldNext():
			ObjectManager.spawnAroundPlayer(wave.entity)
			spawned = true
	if spawned:
		instance.currentWave += 1
