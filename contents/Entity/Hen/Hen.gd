extends BaseEnemy

func spawn():
	super.spawn()
	setStat(Stats.Living.MAX_HEALTH, 1000)
