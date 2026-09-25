class_name TimeUtil

static func millseconds(duration: float):
	return WorldManager.instance.get_tree().create_timer(duration / 1000).timeout
static func current() -> float:
	if is_instance_valid(WorldManager.instance):
		return WorldManager.instance.running * 1000
	else:
		return 0
static func frame():
	return WorldManager.instance.ShrimpPluginManager.frame()
