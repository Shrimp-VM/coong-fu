extends RefCounted
class_name ValueModifier

enum Method {
	ADD,
	MULTIPLY,
	EXP
}

var method: Method
var value: float
var next: ValueModifier

func _init(methox: Method, valux: float, nexx: ValueModifier = null) -> void:
	method = methox
	value = valux
	append(nexx)

func modify(base: float) -> float:
	var result: float
	match method:
		Method.ADD: result = base + value
		Method.MULTIPLY: result = base * value
		Method.EXP: result = base ** value
	if is_instance_valid(next):
		result = next.modify(result)
	return result
func append(nexx: ValueModifier) -> ValueModifier:
	if is_instance_valid(next):
		next.append(nexx)
	else:
		next = nexx
	return self

static func fromChain(modifiers: Array) -> ValueModifier:
	var result = ValueModifier.new(Method.ADD, 0)
	for modifier in modifiers:
		if modifier is ValueModifier:
			result.append(modifier)
	return result
