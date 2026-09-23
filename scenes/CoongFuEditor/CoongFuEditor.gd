@tool
extends ShrimpIREditor
class_name CoongFuEditor

func _ready() -> void:
	blockCounts.merge(ShrimpVMUtil.create_count_map(
		ShrimpVMUtil.get_configured_irs(false)
			 +[RepeatNode.new(), ShrimpRootNode.new()]
	, 0))
	super._ready()
