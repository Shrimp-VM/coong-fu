class_name GameRuleManager

func bulletHitEntity(bullet: BaseBullet, entity: BaseEntity):
	if is_instance_valid(bullet.launcher):
		if bullet.launcher.isPlayer() == entity.isPlayer(): return
