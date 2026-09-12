extends BaseLiving
class_name BasePlayer

@export var dashSpeed: float = 20

func spawn():
	CameraManager.follow(self)
	WorldManager.fightContext.env.write_symbol("player", self)
func ai(delta: float):
	if EditorManager.isOpening(): return
	var controlledDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if dashing: return
	accelerate(controlledDirection, delta, 200)
	if Input.is_action_pressed("attack"):
		enterAttack(0)
	if Input.is_action_just_pressed("dash"):
		dash(GameRuleManager.impactVector(controlledDirection if controlledDirection.length() > 0 else Vector2(faceX, 0), dashSpeed), 200)
func isPlayer() -> bool:
	return true
