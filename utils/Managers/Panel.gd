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
			panel.show()
			add_child(panel)
			panel.animator.play("RESET")

static func close():
	instance.get_tree().paused = false
	if is_instance_valid(instance.current):
		instance.current.z_index = 0
		await instance.current.exit()
	instance.current = null
static func setCurrent(namx: String):
	close()
	instance.get_tree().paused = true
	instance.current = instance.get_node(namx)
	instance.current.z_index = 1
	await instance.current.enter()
static func getCurrent() -> String:
	if !is_instance_valid(instance.current): return ""
	return instance.current.name
