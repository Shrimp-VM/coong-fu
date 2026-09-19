@tool
extends Control
class_name UpgradeBar

signal select()

@export_tool_button("重建") var rebuilder = rebuild
@export var ir: ShrimpIR

@onready var descriptionLabel: RichTextLabel = $%description
@onready var previewBox: PanelContainer = $%previewBox
@onready var selectBtn: Button = $%selectBtn

func _ready() -> void:
	rebuild()
	selectBtn.pressed.connect(select.emit)

func rebuild():
	if !is_instance_valid(ir): return
	var schema = ir.get_wrapper_schema()
	descriptionLabel.text = schema.description
	var preview = NodeBlock.create(null, true, INF, ir.get_node_type())
	ShrimpVMUtil.disconnect_children(previewBox)
	previewBox.add_child(preview)
	preview.rebuild()
func disable():
	selectBtn.disabled = true
