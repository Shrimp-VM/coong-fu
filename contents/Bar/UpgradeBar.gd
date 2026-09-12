@tool
extends Control
class_name UpgradeBar

@export_tool_button("重建") var rebuilder = rebuild
@export var ir: ShrimpIR

@onready var description: RichTextLabel = $%description
@onready var preview: NodeBlock = $%preview

func rebuild():
	if !is_instance_valid(ir): return
	var schema = ir.get_wrapper_schema()
	description.text = schema.description
	preview.rebuild(schema, {"type": ir.get_node_type()})
