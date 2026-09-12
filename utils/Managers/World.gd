@tool
extends Node2D
class_name WorldManager

static var instance: WorldManager
static var fightContext: ExecutionContext = ExecutionContext.new()

@onready var vm: ShrimpVM = $%vm
var running: float = 0

func _ready() -> void:
	instance = self
	ObjectManager.addEntity("Rooster")
func _process(delta: float) -> void:
	running += delta
