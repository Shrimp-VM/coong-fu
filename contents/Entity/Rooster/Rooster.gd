extends BasePlayer
class_name RoosterEntity

func spawn():
	super.spawn()
	setStat(Stats.Living.OFFSET_SHOOT, 10)
func normalAttack():
	var attack = EditorManager.instance.editor.fileManager.search("normalAttack")
	if attack is VirtualFile:
		WorldManager.instance.vm.execute(ShrimpCompiler.import_json(attack.content), WorldManager.instance.fightContext)
