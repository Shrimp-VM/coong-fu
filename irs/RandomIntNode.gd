@tool
extends ShrimpIR
class_name RandomIntNode

func execute(_vm: ShrimpVM, _context: ExecutionContext) -> Variant:
	return randi_range(1, 2)
func decompile() -> Dictionary:
	return {}

static func get_category_tag() -> String:
	return "数值"
static func get_node_type() -> String:
	return "random_int"
static func create_from(_wrapper: Dictionary) -> RandomIntNode:
	return new()
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("随机1~2", {}, "获取一个较小的随机整数")
