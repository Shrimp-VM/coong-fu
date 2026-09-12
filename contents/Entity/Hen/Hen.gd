extends BaseEnemy

func spawn():
	super.spawn()
	setStat(Stats.Living.MAX_HEALTH, 1000)
	attackCooldowns[0] = CooldownController.new(2000)
func getAI() -> Array[BaseAI]:
	return [LivingFollowAI.new(), LivingAttackAI.new({0: [0, 500]})]
func attack(type: int):
	match type:
		0:
			ObjectManager.addBullet("Star", self, getAnchor("shooter"), rotationToFocusing())
