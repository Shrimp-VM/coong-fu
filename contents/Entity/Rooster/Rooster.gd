extends BasePlayer
class_name RoosterEntity

func normalAttack():
	for i in 3:
		for b in ObjectManager.shootToMouse("PurpleCrystal", self):
			if b is BaseBullet:
				b.rotation_degrees += i * 10
