@tool
extends Control
class_name ColorBar

enum TextMode {
	PERCENT,
	FRACTION,
	NONE
}

@export var back: StyleBoxFlat
@export var middleA: StyleBoxFlat
@export var middleB: StyleBoxFlat
@export var front: StyleBoxFlat
@export var textMode: TextMode = TextMode.PERCENT
@export var textAlign: HorizontalAlignment = HORIZONTAL_ALIGNMENT_LEFT
@export var minValue: float = 0
@export var currentValue: float = 50
@export var maxValue: float = 100
@export var followDirection: int = 1

@onready var textLabel: Label = $%text
var backBox: StyleBoxFlat
var middleBoxA: StyleBoxFlat
var middleBoxB: StyleBoxFlat
var frontBox: StyleBoxFlat
var backProgress: float = 1
var middleProgress: float = 0.5
var frontProgress: float = 0.5

func _ready() -> void:
	if back:
		backBox = back.duplicate()
	if middleA:
		middleBoxA = middleA.duplicate()
	if middleB:
		middleBoxB = middleB.duplicate()
	if front:
		frontBox = front.duplicate()
func _physics_process(delta: float) -> void:
	textLabel.horizontal_alignment = textAlign
	match textMode:
		TextMode.PERCENT:
			textLabel.text = "%.1f%%" % (getProgress() * 100)
		TextMode.FRACTION:
			textLabel.text = "%s / %s" % [currentValue - minValue, maxValue - minValue]
		TextMode.NONE:
			textLabel.text = ""
	backProgress = 1
	if followDirection > 0:
		frontProgress = getProgress()
		middleProgress = lerpf(middleProgress, frontProgress, delta)
		middleProgress = max(frontProgress, middleProgress)
	elif followDirection < 0:
		middleProgress = getProgress()
		frontProgress = lerpf(frontProgress, middleProgress, delta)
		frontProgress = min(middleProgress, frontProgress)
	queue_redraw()
func _draw() -> void:
	customDraw(size.x * backProgress, size.x * middleProgress, size.x * frontProgress, size.y)

func customDraw(backWidth: float, middleWidth: float, frontWidth: float, height: float):
	if backBox:
		draw_style_box(backBox, Rect2(0, 0, backWidth, height))
	if middleBoxA:
		draw_style_box(getMiddleState(), Rect2(0, 0, middleWidth, height))
	if frontBox:
		draw_style_box(frontBox, Rect2(0, 0, frontWidth, height))

func getProgress(overrideValue: float = NAN) -> float:
	return clamp(((currentValue if is_nan(overrideValue) else overrideValue) - minValue) / (maxValue - minValue), 0, 1)
func setCurrent(newValue: float):
	followDirection = sign(currentValue - newValue)
	currentValue = newValue
func getMiddleState():
	if followDirection == 0:
		return [middleBoxB, middleBoxA][int(middleProgress < frontProgress)]
	else:
		return [middleBoxB, null, middleBoxA][followDirection + 1]
func fillTo(value: float):
	maxValue = value
	currentValue = value
	middleProgress = getProgress()
	frontProgress = getProgress()
func freeze(frontValue: float, middleValue: float):
	followDirection = 0
	currentValue = frontValue
	frontProgress = getProgress(frontValue)
	middleProgress = getProgress(middleValue)
