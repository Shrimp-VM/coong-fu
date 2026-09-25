@tool
extends BasePanel

@onready var blocksContainer: Control = $%blocks
var irs: Array = ShrimpVMUtil.without(ShrimpVMUtil.scan_ir_nodes(["res://irs/"]), ["inject_full_energy"]) + [RepeatNode.new()]

func beforeEnter():
	ShrimpVMUtil.disconnect_children(blocksContainer)
	var pool = irs.duplicate()
	for i in 3:
		var ir = pool.pick_random()
		pool.erase(ir)
		var bar = preload("res://contents/Bar/UpgradeBar.tscn").instantiate() as UpgradeBar
		bar.ir = ir
		bar.select.connect(
			func():
				for bars in blocksContainer.get_children():
					if bars is UpgradeBar:
						bars.disable()
				EditorManager.instance.editor.store_block(ir.get_node_type())
				PanelManager.close()
		)
		blocksContainer.add_child(bar)
