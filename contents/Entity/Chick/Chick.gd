extends BaseEnemy
class_name ChickEnemy

func spawn():
	setStat(Stats.Living.MAX_HEALTH, 1000)
	setStat(Stats.Living.ATTACK_POWER, 20)
	attackCooldowns[0] = CooldownController.new(2000)
	super.spawn()
func getAI() -> Array[BaseAI]:
	return [LivingFollowAI.new(), LivingAttackAI.new({0: [0, 1000]})]
func attack(type: int):
	match type:
		0:
			ObjectManager.addBullet("Star", self, getAnchor("shooter"), rotationToFocusing())
