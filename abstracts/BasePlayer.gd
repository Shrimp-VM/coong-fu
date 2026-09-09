extends BaseLiving
class_name BasePlayer

func spawn():
	CameraManager.follow(self)
func ai(delta: float):
	accelerate(Input.get_vector("move_left", "move_right", "move_up", "move_down"), delta, 200)
func isPlayer() -> bool:
	return true
