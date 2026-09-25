extends BaseBullet

func spawn():
	setStat(Stats.Bullet.PENETRATE, INF)
func hitEntity(entity: BaseEntity) -> bool:
	if super.hitEntity(entity):
		damageFactor *= 1 - 0.25
		return true
	else: return false
func die():
	await TimeUtil.millseconds(1000)
