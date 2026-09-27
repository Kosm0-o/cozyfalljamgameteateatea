extends Control

var tutorial_on : bool = false

func _ready() -> void:
	eye_move(false)
	for btn in [
		$playbtn,
		$tutorialbtn
	]:
		btn.mouse_entered.connect(highlight.bind(true, btn))
		btn.mouse_exited.connect(highlight.bind(false, btn))

func _process(delta: float) -> void:
	$cup.rotation_degrees += 250 * delta

func highlight(outline : bool, btn):
	btn.material.set_shader_parameter("shader_enabled", outline)

func _on_playbtn_pressed() -> void:
	await eye_move(true)
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_tutorialbtn_pressed() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($tutorialbtn/Panel, "position:x", -725.0 if not tutorial_on else -1638.0, 0.5)
	tutorial_on = not tutorial_on

func eye_move(close : bool):
	var ftween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	ftween.tween_method(eye_alpha, 0.0, 1.0, 0.5)
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_method(eye_shader_progress, 0.0 if close else 1.0, 0.36 if close else 0.461, 0.5)
	tween.tween_method(eye_shader_progress, 0.36 if close else 0.461, 0.124 if close else 0.697, 0.5)
	tween.tween_method(eye_shader_progress, 0.124 if close else 0.697, 0.697 if close else 0.124, 0.5)
	tween.tween_method(eye_shader_progress, 0.697 if close else 0.124, 0.461 if close else 0.36, 0.5)
	tween.tween_method(eye_shader_progress, 0.461 if close else 0.36, 1.0 if close else 0.0, 0.5)
	await tween.finished
	if not close:
		var ftween2 = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		ftween2.tween_method(eye_alpha,1.0, 0.0, 0.5)

func eye_shader_progress(val):
	$eyeshader.material.set_shader_parameter("progress", val)

func eye_alpha(val):
	$eyeshader.material.set_shader_parameter("eyelid_alpha", val)
