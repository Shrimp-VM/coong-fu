@tool
extends ShrimpIR
class_name InjectEnergyNode

func execute(_vm: ShrimpVM, context: ExecutionContext) -> Variant:
	var player = context.env.read_symbol("player")
	if player is BasePlayer:
		player.energyInjected += 10
	return
func decompile() -> Dictionary:
	return {}

static func get_category_tag() -> String:
	return "能量"
static func get_node_type() -> String:
	return "inject_energy"
static func create_from(_wrapper: Dictionary) -> InjectEnergyNode:
	return new()
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("注入10能量", {}, "没有能量的子弹将无法造成伤害。")
