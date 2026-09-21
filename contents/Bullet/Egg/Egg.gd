extends BaseBullet

func getAI() -> Array[BaseAI]:
	return [BulletForwardAI.new(), BulletAccelerateAI.new(1000), BulletTextureRotateAI.new(540)]
