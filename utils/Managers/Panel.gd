extends CanvasLayer
class_name PanelManager

const SCENE_DIR = "res://contents/Panels"

static var instance: PanelManager

var current: BasePanel = null

func _ready() -> void:
	instance = self
	for fp in ResourceLoader.list_directory(SCENE_DIR):
		var panel = (load(SCENE_DIR.path_join(fp)) as PackedScene).instantiate() as BasePanel
		panel.hide()
		add_child(panel)

static func setCurrent(namx: String):
	if is_instance_valid(instance.current):
		instance.current.exit()
	instance.current = instance.get_node(namx)
	await instance.current.enter()
