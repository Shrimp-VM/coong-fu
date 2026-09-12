extends Control
class_name BasePanel

@onready var animator: AnimationPlayer = $%animator

func beforeEnter():
	pass
func afterExit():
	pass

func enter():
	await beforeEnter()
	show()
	animator.play("enter")
	await animator.animation_finished
func exit():
	animator.play("exit")
	await animator.animation_finished
	hide()
	await afterExit()
