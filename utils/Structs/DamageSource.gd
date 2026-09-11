extends RefCounted
class_name DamageSource

enum AmountType {
	HEAL = -1,
	MISS = 0,
	DAMAGE = 1,
}

var from: BaseEntity
var amount: float
var isCrit: bool
var to: BaseEntity

func _init(frox: BaseEntity, amounx: float, isCrix: bool, tx: BaseEntity) -> void:
	from = frox
	amount = amounx
	isCrit = isCrix
	to = tx

func apply():
	to.applyDamage(self)
func getAmountType() -> AmountType:
	return sign(amount)
func getRawValue() -> float:
	return abs(amount)
