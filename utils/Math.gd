class_name MathUtil

static func rate(value: float) -> bool:
	return randf() < value
static func randomAngle() -> Vector2:
	return Vector2.from_angle(randf_range(0, 2 * PI))
static func sampleCircle(radius: float) -> Vector2:
	return sampleRing(0, radius)
static func sampleRing(inner: float, outer: float) -> Vector2:
	return randomAngle() * randf_range(inner, outer)
static func halfDiagonal(size: Vector2) -> float:
	return size.length() / 2
static func weightPick(items: Dictionary) -> Variant:
	var total = 0
	for key in items:
		total += items[key]
	var roll = randi_range(1, total)
	var current = 0
	for key in items:
		current += items[key]
		if roll <= current:
			return key
	if items.is_empty():
		return null
	else:
		return items.keys()[0]
