extends Node2D
class_name ObjectManager

static var instance: ObjectManager

func _ready() -> void:
	instance = self

static func addBullet(namx: String, positiox: Vector2 = Vector2.ZERO, rotatiox: float = 0) -> Array[BaseBullet]:
	var bullet = (load("res://contents/Bullet/%s/%s.tscn" % [namx, namx]) as PackedScene).instantiate() as BaseBullet
	bullet.position = positiox
	bullet.rotation = rotatiox
	instance.add_child(bullet)
	return [bullet]
