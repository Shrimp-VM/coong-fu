@tool
extends Node2D
class_name ObjectManager

static var instance: ObjectManager

func _ready() -> void:
	instance = self

static func addObject(obj: Node):
	instance.add_child(obj)
static func shootToMouse(bullet: String, launcher: BaseEntity, anchor: String = "shootEntry") -> Array[BaseBullet]:
	return addBullet(
		bullet,
		launcher,
		launcher.getAnchor(anchor),
		launcher.getAnchor(anchor).angle_to_point(launcher.get_global_mouse_position())
	)
static func addBullet(namx: String, launcher: BaseEntity, positiox: Vector2 = Vector2.ZERO, rotatiox: float = 0) -> Array[BaseBullet]:
	var bullet = (load("res://contents/Bullet/%s/%s.tscn" % [namx, namx]) as PackedScene).instantiate() as BaseBullet
	bullet.launcher = launcher
	bullet.position = positiox
	bullet.rotation = rotatiox
	if launcher is BaseLiving:
		bullet.rotation_degrees += randf_range(-1, 1) * launcher.getStat(Stats.Living.OFFSET_SHOOT)
		bullet.energyInjected = launcher.energyInjected
		launcher.impact(GameRuleManager.impactVector(Vector2.from_angle(rotatiox), -bullet.recoil))
	instance.add_child(bullet)
	bullet.add_to_group("bullet")
	return [bullet]
static func addEntity(namx: String, positiox: Vector2 = Vector2.ZERO) -> Array[BaseEntity]:
	var entity = (load("res://contents/Entity/%s/%s.tscn" % [namx, namx]) as PackedScene).instantiate() as BaseEntity
	entity.position = positiox
	instance.add_child(entity)
	entity.add_to_group("entity")
	if entity is BaseLiving:
		entity.add_to_group("living")
	if entity.isPlayer():
		entity.add_to_group("player")
	else:
		entity.add_to_group("enemy")
	return [entity]
static func getEnemyCount(type: String) -> int:
	return len(instance.get_tree().get_nodes_in_group("enemy").filter(func(x: Node): return x.get_script().get_global_name() == type))
static func spawnAroundPlayer(namx: String) -> Array[BaseEntity]:
	return addEntity(namx, getPlayer().position + GameRuleManager.enemySpawnOffset())
static func getPlayer() -> BasePlayer:
	var players = instance.get_tree().get_nodes_in_group("player")
	if !players.is_empty():
		return players[0]
	else:
		return null
static func collectAttractonMap(livings: Array) -> Dictionary[BaseLiving, float]:
	return livings.reduce(
		func(current: Dictionary, next):
			if next is BaseLiving:
				return current.merged({next: next.getStat(Stats.Living.ATTRACTION_WEIGHT)}, true)
			else:
				return current,
		{} as Dictionary[BaseLiving, float]
	)
static func addExpBall(positiox: Vector2, impluse: Vector2 = Vector2.RIGHT) -> ExpBall:
	var ball = (load("res://contents/Items/ExpBall.tscn") as PackedScene).instantiate() as ExpBall
	ball.position = positiox
	instance.add_child.call_deferred(ball)
	ball.apply_impulse(impluse.normalized() * randf_range(100, 200))
	return ball
