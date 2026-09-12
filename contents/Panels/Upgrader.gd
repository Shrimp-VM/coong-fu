@tool
extends BasePanel

@onready var blocksContainer: Control = $%blocks
var irs: Array[ShrimpIR] = ShrimpVMUtil.scan_ir_nodes(["res://irs"])

func beforeEnter():
	ShrimpVMUtil.disconnect_children(blocksContainer)
	for i in 3:
		var ir = irs.pick_random()
		var bar = preload("res://contents/Bar/UpgradeBar.tscn").instantiate() as UpgradeBar
		bar.ir = ir
		bar.select.connect(
			func():
				EditorManager.instance.editor.store_block(ir.get_node_type())
				PanelManager.close()
				for bars in blocksContainer.get_children():
					if bars is UpgradeBar:
						bars.disable()
		)
		blocksContainer.add_child(bar)
