class_name MathUtil

static func rate(value: float) -> bool:
	return randf() < value
static func sampleCircle(radius: float) -> Vector2:
	return Vector2.from_angle(randf_range(0, 2 * PI)) * randf_range(0, radius)
