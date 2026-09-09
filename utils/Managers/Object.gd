extends Node2D
class_name ObjectManager

static var instance: ObjectManager

func _ready() -> void:
	instance = self

static func shootToMouse(bullet: String, launcher: BaseEntity, anchor: String = "shootEntry"):
	addBullet(
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
	instance.add_child(bullet)
	return [bullet]
