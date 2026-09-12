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
		bar.select.connect(PanelManager.close)
		blocksContainer.add_child(bar)
