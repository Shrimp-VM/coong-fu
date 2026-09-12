extends BaseLiving.BaseAI
class_name LivingFollowAI

func physics(living: BaseLiving, delta: float):
	if !is_instance_valid(living.focusingEntity): return
	living.accelerate(living.focusingEntity.position - living.position, delta, 100)
