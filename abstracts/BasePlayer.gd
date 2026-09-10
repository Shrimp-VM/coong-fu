extends BaseLiving
class_name BasePlayer

func spawn():
	CameraManager.follow(self)
	WorldManager.fightContext.env.write_symbol("player", self)
func ai(delta: float):
	if EditorManager.isOpening(): return
	accelerate(Input.get_vector("move_left", "move_right", "move_up", "move_down"), delta, 200)
	if Input.is_action_pressed("attack"):
		if !attackCooldown.flag(): return
		normalAttack()
func isPlayer() -> bool:
	return true
func normalAttack():
	pass
