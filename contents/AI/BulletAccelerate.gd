extends BaseBullet.BaseAI
class_name BulletAccelerateAI

var duration: float
var target: float

func _init(duratiox: float) -> void:
	duration = duratiox
func config(bullet: BaseBullet):
	target = bullet.baseMovement
func physics(bullet: BaseBullet, _delta: float):
	bullet.baseMovement = target * (bullet.timeLived() / duration)
