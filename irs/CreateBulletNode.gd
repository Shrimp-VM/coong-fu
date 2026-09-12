@tool
extends ShrimpIR
class_name CreateBulletNode

@export var content: int

func execute(_vm: ShrimpVM, _context: ExecutionContext) -> Variant:
	return get_keys_type("content")[content]

static func get_category_tag() -> String:
	return "子弹"
static func create_from(wrapper: Dictionary) -> CreateBulletNode:
	var result = new()
	result.content = wrapper.content
	return result
static func get_node_type() -> String:
	return "create_bullet"
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("凝聚子弹", {
		"content": Model.attribute_schema(
			["PurpleCrystal"],
			"子弹类型"
		)
	}, "发射子弹前必须凝聚。")
