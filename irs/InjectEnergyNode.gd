@tool
extends ShrimpIR
class_name InjectEnergyNode

@export var energy: ShrimpIR

func execute(vm: ShrimpVM, context: ExecutionContext) -> Variant:
	var player = context.env.read_symbol("player")
	if player is BasePlayer:
		player.energyInjected += await vm.execute(energy, context)
	return
func decompile() -> Dictionary:
	return {}

static func get_category_tag() -> String:
	return "通用攻击"
static func get_node_type() -> String:
	return "inject_energy"
static func create_from(wrapper: Dictionary) -> InjectEnergyNode:
	var result = new()
	result.energy = ShrimpCompiler.compile(wrapper.energy)
	return result
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("注入少量能量", {
		"energy": Model.attribute_schema(ShrimpIR.TYPE_ENUM, "数量")
	}, "没有能量的子弹将无法造成伤害。")
