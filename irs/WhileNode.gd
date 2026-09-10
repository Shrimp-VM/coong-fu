@tool
extends ShrimpIR
class_name WhileNode

@export var count: ShrimpIR
@export var body: Array[ShrimpIR]

func execute(vm: ShrimpVM, context: ExecutionContext) -> Variant:
	for i in await vm.execute(count, context):
		var newContext = ExecutionContext.new(context)
		await vm.execute_all(body, newContext)
	return

static func get_category_tag() -> String:
	return "控制流"
static func get_node_type() -> String:
	return "while"
static func create_from(wrapper: Dictionary) -> WhileNode:
	var result = new()
	result.count = ShrimpCompiler.compile(wrapper.count)
	result.body = ShrimpCompiler.compile_body(wrapper.body)
	return result
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("重复执行", {
		"count": Model.attribute_schema(ShrimpIR.TYPE_ENUM, "次数"),
		"body": Model.attribute_schema(ShrimpIR.TYPE_ENUM, "内容", true)
	})
