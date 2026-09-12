extends BaseLiving
class_name BaseEnemy

func isPlayer() -> bool:
	return false
func ai(delta: float):
	super.ai(delta)
	if !is_instance_valid(focusingEntity):
		focusingEntity = ObjectManager.attractPlayer()
