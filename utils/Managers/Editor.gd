extends Node
class_name EditorManager

static var instance: EditorManager

@onready var editor: ShrimpIREditor = $editor

func _ready() -> void:
	instance = self
	editor.blockCounts = ShrimpVMUtil.create_count_map(ShrimpVMUtil.get_configured_irs(), 0)
	editor.rebuild_desk()
	editor.store_block("bullet_shoot")
	editor.store_block("inject_energy")
	editor.store_block("create_bullet")
	editor.store_block("file_change_name")
	editor.store_block("root", 10)
	editor.rebuild_desk()
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("editor"):
		editor.visible = !editor.visible
		get_tree().paused = editor.visible

static func isOpening() -> bool:
	return instance.editor.visible
