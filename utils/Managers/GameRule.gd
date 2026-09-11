class_name GameRuleManager

static func bulletHitEntity(bullet: BaseBullet, entity: BaseEntity):
	if is_instance_valid(bullet.launcher):
		if bullet.launcher.isPlayer() == entity.isPlayer(): return
	bullet.hitEntity(entity)
static func judgeCirt(launcher: BaseEntity, base: float = 0):
	if launcher is BaseLiving:
		var state = MathUtil.rate(launcher.getStat(Stats.Living.CRIT_RATE))
		return [state, base * (1 + int(state) * launcher.getStat(Stats.Living.CRIT_DAMAGE))]
	else:
		return [false, base]
