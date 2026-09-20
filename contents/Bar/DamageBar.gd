extends Node2D
class_name DamageBar

@onready var textLabel: Label = $%text
@onready var animator: AnimationPlayer = $%animator
var damage: DamageSource

func _ready() -> void:
	position += MathUtil.sampleCircle(20)
	rebuild()
	animator.play("spawn")
	await animator.animation_finished
	queue_free()

func rebuild():
	if is_instance_valid(damage):
		textLabel.text = "%d" % damage.getRawValue()

static func create(dmg: DamageSource) -> DamageBar:
	var instance = preload("res://contents/Bar/DamageBar.tscn").instantiate() as DamageBar
	instance.damage = dmg
	return instance
