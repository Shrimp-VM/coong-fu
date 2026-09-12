@tool
extends ShrimpIR
class_name SpeedUpNode

class SpeedUpEffect extends FightHook:
	func getLivingStatsModifiers(_l) -> Dictionary[Stats.Living, ValueModifier]:
		return {
			Stats.Living.ATTACK_SPEED: ValueModifier.new(ValueModifier.Method.ADD, 0.1)
		}
	func onLivingAttack(_living: BaseLiving, _type: int):
		exit()

func execute(_vm: ShrimpVM, context: ExecutionContext) -> Variant:
	var player = context.env.read_symbol("player")
	if player is BasePlayer:
		player.hook.subscribe(SpeedUpEffect.new())
	return

static func get_category_tag() -> String:
	return "攻击"
static func get_node_type() -> String:
	return "speedup"
static func create_from(_wrapper: Dictionary) -> SpeedUpNode:
	return new()
static func get_wrapper_schema() -> Dictionary:
	return Model.wrapper_schema("下一次攻击加快10%", {}, "等效于攻击速度+10%")
