extends Control

signal dialogue_finished()

@onready var bg: ColorRect = $ColorRect
@onready var lbl: Label = $ColorRect/Label


func _ready() -> void:
	get_parent().trigger_dialogue.connect(_dialogue_tween)
	
func _dialogue_tween(text : String):
	lbl.size = bg.size
	lbl.visible_ratio = 0.0
	lbl.text = text
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	tween.tween_property(lbl, "visible_ratio", 1.0, len(text) * 0.035)
	await tween.finished
	await get_tree().create_timer(0.75).timeout
	dialogue_finished.emit()
