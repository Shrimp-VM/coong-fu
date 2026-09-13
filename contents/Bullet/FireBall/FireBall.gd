extends BaseBullet

@onready var smoke: GPUParticles2D = $%smoke
@onready var fireHead: GPUParticles2D = $%fireHead
@onready var fireTrail: GPUParticles2D = $%fireTrail

func getAI() -> Array[BaseAI]:
	return [BulletForwardAI.new(), BulletAccelerateAI.new(1000)]
func die():
	smoke.emitting = false
	fireHead.emitting = false
	fireTrail.emitting = false
	await TimeUtil.millseconds(3000)
