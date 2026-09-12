@tool
extends BasePanel

@onready var blocksContainer: Control = $%blocks

func beforeEnter():
	print(ShrimpVMUtil.scan_ir_nodes(["res://irs/"]))
