extends BaseBullet

@onready var smoke: GPUParticles2D = $%smoke
@onready var fireHead: GPUParticles2D = $%fireHead
@onready var fireTrail: GPUParticles2D = $%fireTrail

func getAI() -> Array[BaseAI]:
	return [BulletForwardAI.new()]
func die():
	await NodeUtil.waitParticlesFinished(fireHead)
	print(2)
	await NodeUtil.waitParticlesFinished(fireTrail)
	print(3)
	await NodeUtil.waitParticlesFinished(smoke)
	print(1)
