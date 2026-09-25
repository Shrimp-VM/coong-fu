extends Node2D
class_name DamageBar

@export var damageColor: Color
@export var critColor: Color
@export var missColor: Color
@export var healColor: Color

@onready var textLabel: Label = $%text
@onready var animator: AnimationPlayer = $%animator
var damage: DamageSource

func _ready() -> void:
	rebuild()
	animator.play("spawn")
	await animator.animation_finished
	queue_free()

func rebuild():
	if is_instance_valid(damage):
		match damage.getAmountType():
			DamageSource.AmountType.DAMAGE:
				if damage.isCrit:
					textLabel.text = "%d!!!" % damage.getRawValue()
					textLabel.label_settings.font_color = critColor
				else:
					textLabel.text = "%d" % damage.getRawValue()
					textLabel.label_settings.font_color = damageColor
			DamageSource.AmountType.MISS:
				textLabel.text = "MISS"
				textLabel.label_settings.font_color = missColor
			DamageSource.AmountType.HEAL:
				textLabel.text = "+%d" % damage.getRawValue()
				textLabel.label_settings.font_color = healColor

static func create(dmg: DamageSource) -> DamageBar:
	var instance = preload("res://contents/Bar/DamageBar.tscn").instantiate() as DamageBar
	instance.damage = dmg
	instance.position = dmg.to.position + MathUtil.sampleCircle(30)
	return instance
