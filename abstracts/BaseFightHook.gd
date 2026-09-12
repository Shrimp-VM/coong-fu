extends RefCounted
class_name FightHook

signal queueExit()

func getLivingStatsModifiers(_living: BaseLiving) -> Dictionary[Stats.Living, ValueModifier]:
	return {}
func onLivingAttack(_living: BaseLiving, _type: int):
	pass

func exit():
	queueExit.emit()
