class_name GameRuleManager

static func bulletHitEntity(bullet: BaseBullet, entity: BaseEntity):
	if entity.isInvincible(): return
	if !bullet.isLiving(): return
	if is_instance_valid(bullet.launcher):
		if bullet.launcher.isPlayer() == entity.isPlayer(): return
	if bullet.hitEntity(entity):
		bullet.currentPenetrated += 1
static func judgeDamage(launcher: BaseEntity, base: float = 0):
	if launcher is BaseLiving:
		var state = MathUtil.rate(launcher.getStat(Stats.Living.CRIT_RATE))
		return [state, base * (1 + randf_range(-1, 1) * 0.2) * (1 + int(state) * launcher.getStat(Stats.Living.CRIT_DAMAGE))]
	else:
		return [false, base]
static func energyMapDamage(energy: float) -> float:
	return energy * 0.01
static func impactVector(direction: Vector2, speed: float):
	return direction.normalized() * speed * 100
static func enemySpawnOffset() -> Vector2:
	var inner = MathUtil.halfDiagonal(CameraManager.getScreenSize())
	return MathUtil.sampleRing(inner, inner + 500)
