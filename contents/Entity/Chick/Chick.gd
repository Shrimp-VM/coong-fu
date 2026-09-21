extends BaseEnemy
class_name ChickEnemy

func spawn():
	setStat(Stats.Living.MAX_HEALTH, 1000)
	setStat(Stats.Living.ATTACK_POWER, 50)
	attackCooldowns[0] = CooldownController.new(5000)
	super.spawn()
func getAI() -> Array[BaseAI]:
	return [LivingFollowAI.new(), LivingAttackAI.new({0: [0, 1000]})]
func attack(type: int):
	match type:
		0:
			var rot = rotationToFocusing()
			for i in 3:
				ObjectManager.addBullet("Egg", self, getAnchor("shooter"), rot + (i - 1) * deg_to_rad(10))
				await TimeUtil.millseconds(200)
