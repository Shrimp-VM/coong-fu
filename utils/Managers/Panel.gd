extends CanvasLayer
class_name PanelManager

const SCENE_DIR = "res://contents/Panels"

static var instance: PanelManager

var current: BasePanel = null

func _ready() -> void:
	instance = self
	for fp in ResourceLoader.list_directory(SCENE_DIR):
		var scene = load(SCENE_DIR.path_join(fp))
		if scene is PackedScene:
			var panel = scene.instantiate() as BasePanel
			panel.hide()
			add_child(panel)

static func close():
	instance.get_tree().paused = false
	if is_instance_valid(instance.current):
		var currency = instance.current
		await currency.exit()
		currency.hide()
	instance.current = null
static func setCurrent(namx: String):
	close()
	instance.get_tree().paused = true
	instance.current = instance.get_node(namx)
	instance.current.show()
	await instance.current.enter()
static func getCurrent() -> String:
	if !is_instance_valid(instance.current): return ""
	return instance.current.name
