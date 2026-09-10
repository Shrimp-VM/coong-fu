@tool
extends ShrimpIR
class_name BulletShootNode

@export var bullet: ShrimpIR

func execute(vm: ShrimpVM, context: ExecutionContext) -> Variant:
	return ObjectManager.shootToMouse(await vm.execute(bullet, context), context.env.read_symbol("player"))

static func get_category_tag() -> String:
	return "攻击"
static func get_node_type() -> String:
	return "bullet_shoot"
static func create_from(wrapper: Dictionary) -> BulletShootNode:
	var result = new()
	result.bullet = ShrimpCompiler.compile(wrapper.bullet)
	return result
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("向鼠标发射子弹", {
		"bullet": Model.attribute_schema(ShrimpIR.TYPE_ENUM, "子弹")
	})
