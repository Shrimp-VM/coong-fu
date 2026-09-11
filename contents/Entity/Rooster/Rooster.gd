extends BasePlayer
class_name RoosterEntity

func spawn():
	super.spawn()
	setStat(Stats.Living.OFFSET_SHOOT, 10)
	await get_tree().process_frame
	for i in 10:
		ObjectManager.addEntity("Hen", MathUtil.sampleCircle(500))
func normalAttack():
	var attack = EditorManager.instance.editor.fileManager.search("normalAttack")
	if attack is VirtualFile:
		WorldManager.instance.vm.execute(ShrimpCompiler.import_json(attack.content), WorldManager.instance.fightContext)
