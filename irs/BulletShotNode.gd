@tool
extends ShrimpIR
class_name BulletShootNode

func execute(_vm: ShrimpVM, _context: ExecutionContext) -> Variant:
	return

static func get_category_tag() -> String:
	return "攻击"
static func get_node_type() -> String:
	return "bullet_shoot"
static func create_from(_wrapper: Dictionary) -> BulletShootNode:
	return new()
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("发射一枚标准子弹", {})
