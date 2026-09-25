extends Node
class_name EditorManager

static var instance: EditorManager

@onready var editor: ShrimpIREditor = $%editor

func _ready() -> void:
	instance = self
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("editor"):
		if isOpening():
			PanelManager.close()
		else:
			open()

static func open():
	PanelManager.setCurrent("Editor")
	instance.editor.rebuild()
static func isOpening() -> bool:
	return PanelManager.getCurrent() == "Editor"
