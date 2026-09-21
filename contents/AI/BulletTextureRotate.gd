extends BaseBullet.BaseAI
class_name BulletTextureRotateAI

var speed: float

func _init(speex: float) -> void:
	speed = speex

func physics(bullet: BaseBullet, delta: float):
	bullet.texture.rotation_degrees += speed * delta
