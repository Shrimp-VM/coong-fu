extends BaseLiving.BaseAI
class_name LivingAttackAI

var distances: Dictionary[int, Array]

func _init(distancex: Dictionary[int, Array]) -> void:
	distances = distancex

func physics(living: BaseLiving, _delta: float):
	if !is_instance_valid(living.focusingEntity): return
	for attack in distances:
		var minD = distances[attack][0]
		var maxD = distances[attack][1]
		var d = living.distanceToFocusing()
		if d >= minD && d <= maxD:
			living.enterAttack(attack)
