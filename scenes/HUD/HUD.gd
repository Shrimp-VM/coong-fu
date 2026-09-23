extends Control
class_name HUDPlayer

static var instance: HUDPlayer

@onready var expBar: ColorBar = $%exp

func _ready() -> void:
	instance = self
	setExp(0)

static func setExp(value: float):
	instance.expBar.setCurrent(value)
