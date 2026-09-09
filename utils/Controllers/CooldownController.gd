extends RefCounted
class_name CooldownController

var cooldown: float
var lastFlag: float

func _init(cooldowx: float, canFlag: bool = false) -> void:
	cooldown = cooldowx
	if canFlag:
		lastFlag = - cooldown
	else:
		lastFlag = TimeUtil.current()

func timeSince():
	return TimeUtil.current() - lastFlag
func canFlagNow() -> bool:
	return timeSince() >= cooldown
func flag() -> bool:
	if canFlagNow():
		lastFlag = TimeUtil.current()
		return true
	else:
		return false
