extends RefCounted
class_name CooldownController

var cooldown: float
var lastFlag: float
var locking: bool = false
var cooldownSpeed: float = 1

func _init(cooldowx: float, canFlag: bool = false) -> void:
	cooldown = cooldowx
	if canFlag:
		lastFlag = - cooldown
	else:
		lastFlag = TimeUtil.current()

func scaledCooldown() -> float:
	return cooldown / cooldownSpeed
func timeSince():
	return TimeUtil.current() - lastFlag
func canFlagNow() -> bool:
	return !locking && timeSince() >= scaledCooldown()
func flag() -> bool:
	if canFlagNow():
		lastFlag = TimeUtil.current()
		return true
	else:
		return false
func lock():
	locking = true
func unlock():
	lastFlag = TimeUtil.current()
	locking = false
