@tool
extends Control
class_name UpgradeBar

signal select()

@export_tool_button("重建") var rebuilder = rebuild
@export var ir: ShrimpIR

@onready var descriptionLabel: RichTextLabel = $%description
@onready var preview: NodeBlock = $%preview
@onready var selectBtn: Button = $%selectBtn

func _ready() -> void:
	rebuild()
	selectBtn.pressed.connect(select.emit)

func rebuild():
	if !is_instance_valid(ir): return
	var schema = ir.get_wrapper_schema()
	descriptionLabel.text = schema.description
	preview.rebuild()
func disable():
	selectBtn.disabled = true
