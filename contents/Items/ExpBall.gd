extends RigidBody2D
class_name ExpBall

const ATTRACT_DISTANCE = 300
const COLLECT_DISTANCE = 50

@export var value: float = 100

var attracted: BasePlayer

func _physics_process(delta: float) -> void:
	if is_instance_valid(attracted):
		apply_central_force((attracted.position - position).normalized() * 50000 * delta)
		if position.distance_to(attracted.position) < COLLECT_DISTANCE:
			collect(attracted)
	else:
		var player = ObjectManager.getPlayer()
		if is_instance_valid(player):
			if position.distance_to(player.position) < ATTRACT_DISTANCE:
				attracted = player

func collect(player: BasePlayer):
	player.storeExp(value)
	queue_free()
