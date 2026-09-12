extends Node
class_name EditorManager

static var instance: EditorManager

@onready var editor: ShrimpIREditor = $editor

func _ready() -> void:
	instance = self
	editor.build_desk(ShrimpVMUtil.get_configured_irs())
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("editor"):
		editor.visible = !editor.visible
		get_tree().paused = editor.visible

static func isOpening() -> bool:
	return instance.editor.visible
