@tool
extends ShrimpIR
class_name BulletShootNode

@export var bullet: ShrimpIR

func execute(vm: ShrimpVM, context: ExecutionContext) -> Variant:
	var player = context.env.read_symbol("player")
	if player is BasePlayer:
		ObjectManager.shootToMouse(await vm.execute(bullet, context), player)
		player.energyInjected = 0
		await TimeUtil.millseconds(50)
	return
func decompile() -> Dictionary:
	return {
		"bullet": ShrimpCompiler.decompile(bullet)
	}

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
	}, "顾名思义，发射一颗子弹。")
