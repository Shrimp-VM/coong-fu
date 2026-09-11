extends Node2D
class_name ObjectManager

static var instance: ObjectManager

func _ready() -> void:
	instance = self

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
	instance.add_child(bullet)
	return [bullet]
static func addEntity(namx: String, positiox: Vector2 = Vector2.ZERO) -> Array[BaseEntity]:
	var entity = (load("res://contents/Entity/%s/%s.tscn" % [namx, namx]) as PackedScene).instantiate() as BaseEntity
	entity.position = positiox
	instance.add_child(entity)
	return [entity]
