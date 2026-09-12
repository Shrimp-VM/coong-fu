extends BasePlayer
class_name RoosterEntity

func spawn():
	super.spawn()
	setStat(Stats.Living.OFFSET_SHOOT, 10)
	attackCooldowns[0] = CooldownController.new(500)
func attack(type: int):
	match type:
		0:
			var script = EditorManager.instance.editor.fileManager.search("normalAttack")
			if script is VirtualFile:
				await WorldManager.instance.vm.execute(ShrimpCompiler.import_json(script.content), WorldManager.instance.fightContext)
