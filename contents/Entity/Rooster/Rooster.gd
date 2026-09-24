extends BasePlayer
class_name RoosterEntity

func spawn():
	super.spawn()
	setStat(Stats.Living.OFFSET_SHOOT, 10)
	attackCooldowns[0] = CooldownController.new(500)
func attack(type: int):
	match type:
		0:
			await WorldManager.instance.vm.execute(EditorManager.instance.editor.fileManager.get_compilation("普通攻击"), WorldManager.instance.fightContext)
