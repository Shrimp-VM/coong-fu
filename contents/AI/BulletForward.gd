extends BaseBullet.BaseAI
class_name BulletForwardAI

func physics(bullet: BaseBullet, delta: float):
	bullet.position += Vector2.from_angle(bullet.rotation) * bullet.baseMovement * delta
