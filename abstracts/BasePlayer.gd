extends BaseLiving
class_name BasePlayer

const UPGRADE_COST_INIT = 300
const UPGRADE_COST_PERLEVEL = 600

@export var dashSpeed: float = 50

var hurtCooldown: CooldownController = CooldownController.new(1000)
var expCount: float = 0
var currentLevel: int = 0

func spawn():
	CameraManager.follow(self)
	WorldManager.fightContext.env.write_symbol("player", self)
	damageTaken.connect(func(_d): hurtCooldown.flag())
func ai(delta: float):
	super.ai(delta)
	if EditorManager.isOpening(): return
	var controlledDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if dashing: return
	accelerate(controlledDirection, delta, 200)
	if Input.is_action_pressed("attack"):
		enterAttack(0)
	if Input.is_action_just_pressed("dash"):
		dash(GameRuleManager.impactVector(controlledDirection if controlledDirection.length() > 0 else Vector2(faceX, 0), dashSpeed))
func isPlayer() -> bool:
	return true
func isInvincible() -> bool:
	return !hurtCooldown.canFlagNow() || super.isInvincible()
func die() -> bool:
	return false

func getUpgradeCost() -> float:
	return UPGRADE_COST_INIT + currentLevel * UPGRADE_COST_PERLEVEL
func canUpgrade() -> bool:
	return expCount >= getUpgradeCost()
func setExp(value: float):
	expCount = value
	HUDPlayer.instance.expBar.maxValue = getUpgradeCost()
	HUDPlayer.setExp(expCount)
func upgrade() -> bool:
	if canUpgrade():
		setExp(expCount - getUpgradeCost())
		currentLevel += 1
		return true
	else:
		return false
func storeExp(count: float):
	setExp(expCount + count)
	if upgrade():
		PanelManager.setCurrent("Upgrader")
