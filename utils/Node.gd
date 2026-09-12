class_name NodeUtil

static func waitParticlesFinished(particle: GPUParticles2D):
	if particle.emitting:
		particle.emitting = false
		await TimeUtil.millseconds(particle.lifetime * 1000)
