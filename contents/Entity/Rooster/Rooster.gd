extends BasePlayer
class_name RoosterEntity

func spawn():
	super.spawn()
	setStat(Stats.Living.OFFSET_SHOOT, 10)
	await get_tree().process_frame
	for i in 10:
		ObjectManager.addEntity("Hen", MathUtil.sampleCircle(500))
func attack(type: int):
	match type:
		0:
			var script = EditorManager.instance.editor.fileManager.search("normalAttack")
			if script is VirtualFile:
				WorldManager.instance.vm.execute(ShrimpCompiler.import_json(script.content), WorldManager.instance.fightContext)
