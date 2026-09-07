@tool
extends Node2D

@onready var editor: ShrimpIREditor = $"%IR-Editor"

func _ready() -> void:
	editor.build_desk(ShrimpVMUtil.get_configured_ir_nodes())
