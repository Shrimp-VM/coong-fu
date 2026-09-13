extends BaseBullet

@onready var smoke: GPUParticles2D = $%smoke
@onready var fireHead: GPUParticles2D = $%fireHead
@onready var fireTrail: GPUParticles2D = $%fireTrail

func getAI() -> Array[BaseAI]:
	return [BulletForwardAI.new(), BulletAccelerateAI.new(1000)]
func die():
	smoke.emitting = false
	fireHead.emitting = false
	fireHead.speed_scale = 1
	fireTrail.emitting = false
	fireTrail.speed_scale = 1
	await TimeUtil.millseconds(3000)
