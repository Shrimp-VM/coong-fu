extends BasePlayer
class_name RoosterEntity

func normalAttack():
	ObjectManager.shootToMouse("PurpleCrystal", self)
