extends Node
class_name EditorManager

static var instance: EditorManager

@onready var editor: ShrimpIREditor = $%editor

func _ready() -> void:
	instance = self
	editor.blockCounts = ShrimpVMUtil.create_count_map(ShrimpVMUtil.get_configured_irs(), 0)
	editor.rebuild_desk()
	editor.store_block("file_change_name")
	editor.store_block("root", 10)
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("editor"):
		if isOpening():
			PanelManager.close()
		else:
			PanelManager.setCurrent("Editor")

static func isOpening() -> bool:
	return PanelManager.getCurrent() == "Editor"
