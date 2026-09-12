@tool
extends Camera2D
class_name CameraManager

static var instance: CameraManager

var following: Node2D = null

func _ready() -> void:
	instance = self
func _physics_process(_delta: float) -> void:
	if is_instance_valid(following):
		position = following.global_position

static func follow(node: Node2D):
	instance.following = node
static func getScreenSize() -> Vector2:
	return instance.get_viewport_rect().size
