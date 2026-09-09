extends Area2D
class_name BaseBullet

class BaseAI extends Resource:
	func run(bullet: BaseBullet):
		return bullet
	func physics(bullet: BaseBullet, delta: float):
		return [bullet, delta]

@export var baseMovement: float = 100

var launcher: BaseEntity
var ais: Array[BaseAI] = []

func _physics_process(delta: float) -> void:
	for ai in ShrimpVMUtil.concat_array(ais, getAI()):
		if ai is BaseAI:
			ai.physics(self, delta)

func getAI() -> Array[BaseAI]:
	return []
