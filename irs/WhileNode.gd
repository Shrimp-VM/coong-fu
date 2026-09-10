@tool
extends ShrimpIR
class_name WhileNode

func execute(_vm: ShrimpVM, _context: ExecutionContext) -> Variant:
	return

static func get_category_tag() -> String:
	return "控制流"
static func get_node_type() -> String:
	return "while"
static func create_from(_wrapper: Dictionary) -> WhileNode:
	return new()
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("重复执行", {
		"count": Model.attribute_schema(ShrimpIR.TYPE_ENUM, "次数"),
		"body": Model.attribute_schema(ShrimpIR.TYPE_ENUM, "内容", true)
	})
