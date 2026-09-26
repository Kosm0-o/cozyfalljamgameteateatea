extends Control

signal dialogue_finished(times : int)

@onready var bg: ColorRect = $ColorRect
@onready var lbl: Label = $ColorRect/Label

var cam : Camera2D = null
var follow_cam : bool = false
const CAM_Y_OFFSET = 324.0
const X_OFFSET = -304.0
var times : int = 0

func _ready() -> void:
	get_parent().trigger_dialogue.connect(_dialogue_tween)
	
func _process(delta: float) -> void:
	if follow_cam:
		position.y = lerp(position.y, cam.position.y - CAM_Y_OFFSET, 3 * delta)
		position.x = lerp(position.x, X_OFFSET if cam.position.y == CAM_Y_OFFSET * 2 else 0.0, 7 * delta)
	
func _dialogue_tween(text : String):
	times += 1
	lbl.size = bg.size
	lbl.visible_ratio = 0.0
	lbl.text = text
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	tween.tween_property(lbl, "visible_ratio", 1.0, len(text) * 0.035)
	await tween.finished
	await get_tree().create_timer(0.75).timeout
	dialogue_finished.emit(times)
	follow_cam = true
