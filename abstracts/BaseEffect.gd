extends Node2D
class_name BaseEffect

@export var autoShot: bool = false
@export var autoFree: bool = true

@onready var particles: GPUParticles2D = $%particles
@onready var shotSound: AudioStreamPlayer = $%shotSound

func _ready() -> void:
	particles.emitting = false
	particles.one_shot = true
	if autoShot:
		shot()
func shot():
	if shotSound.stream:
		shotSound.play()
	if particles.emitting:
		await particles.finished
	particles.restart()
	await particles.finished
	if shotSound.playing:
		await shotSound.finished
	if autoFree:
		queue_free()
