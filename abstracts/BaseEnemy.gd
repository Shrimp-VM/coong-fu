extends BaseLiving
class_name BaseEnemy

@export var value: Vector2i = Vector2i(3, 6)

func isPlayer() -> bool:
	return false
func ai(delta: float):
	super.ai(delta)
	if !is_instance_valid(focusingEntity):
		focusingEntity = ObjectManager.getPlayer()
func die() -> bool:
	for i in randi_range(value.x, value.y):
		ObjectManager.addExpBall(position, MathUtil.randomAngle())
	return true
