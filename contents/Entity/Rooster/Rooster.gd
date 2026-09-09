extends BasePlayer
class_name RoosterEntity

func normalAttack():
	ObjectManager.addBullet("PurpleCrystal", getAnchor("shootEntry"), getAnchor("shootEntry").angle_to_point(get_global_mouse_position()))
