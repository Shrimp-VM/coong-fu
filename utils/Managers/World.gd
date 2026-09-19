@tool
extends Node2D
class_name WorldManager

static var instance: WorldManager
static var fightContext: ExecutionContext = ExecutionContext.new()

@onready var vm: ShrimpVM = $%vm
@onready var hook: HookController = $%hook
var running: float = 0

func _ready() -> void:
	instance = self
	if !Engine.is_editor_hint():
		ObjectManager.addEntity("Rooster")
func _process(delta: float) -> void:
	running += delta
