extends Node
class_name HookController

enum EventName {
	getLivingStatsModifiers,
	onLivingAttack
}

var hooks: Array[FightHook] = []

func callEvent(event: EventName, data: Array = []) -> Array:
	var result = []
	for hook in hooks:
		result.append(hook.callv(getEventMethod(event), data))
	return result
func unsubscribe(hook: FightHook):
	if hook not in hooks: return
	hooks.erase(hook)
func subscribe(hook: FightHook):
	if hook in hooks: return
	hooks.append(hook)
	hook.queueExit.connect(func(): unsubscribe(hook))

static func getEventMethod(event: EventName) -> StringName:
	return EventName.find_key(event)
