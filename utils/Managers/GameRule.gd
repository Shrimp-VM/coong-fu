class_name GameRuleManager

static func bulletHitEntity(bullet: BaseBullet, entity: BaseEntity):
	if is_instance_valid(bullet.launcher):
		if bullet.launcher.isPlayer() == entity.isPlayer(): return
	if bullet.hitEntity(entity):
		bullet.currentPenetrated += 1
		if bullet.isFullPenetrated():
			pass
static func judgeCirt(launcher: BaseEntity, base: float = 0):
	if launcher is BaseLiving:
		var state = MathUtil.rate(launcher.getStat(Stats.Living.CRIT_RATE))
		return [state, base * (1 + int(state) * launcher.getStat(Stats.Living.CRIT_DAMAGE))]
	else:
		return [false, base]
static func energyMapDamage(energy: float) -> float:
	return energy * 0.1
static func impactVector(direction: Vector2, speed: float):
	return direction.normalized() * speed * 100
