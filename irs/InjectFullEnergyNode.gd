@tool
extends ShrimpIR
class_name InjectFullEnergyNode

func execute(_vm: ShrimpVM, context: ExecutionContext) -> Variant:
	var player = context.env.read_symbol("player")
	if player is BasePlayer:
		player.energyInjected += GameRuleManager.FULL_ENERGY
	return
func decompile() -> Dictionary:
	return {}

static func get_category_tag() -> String:
	return "通用攻击"
static func get_node_type() -> String:
	return "inject_full_energy"
static func create_from(_wrapper: Dictionary) -> InjectFullEnergyNode:
	return new()
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("充满能量", {}, "没有能量的子弹将无法造成伤害。")
