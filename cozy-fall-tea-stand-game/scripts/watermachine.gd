extends Sprite2D

signal finished_pouring(temp : global.INGREDIENTS)

var time : float = 0.0
var limit : float = 3.0

var current_temp : global.INGREDIENTS 

func _ready() -> void:
	for btn in [
		$cold,
		$hot
	]:
		btn.material = btn.material.duplicate()
		btn.mouse_entered.connect(highlight.bind(true, btn))
		btn.mouse_exited.connect(highlight.bind(false, btn))
		btn.button_down.connect(func():$sfx.play())
		btn.button_up.connect(func(): $sfx.stop())
	

func _process(delta: float) -> void:
	if $cold.button_pressed or $hot.button_pressed:
		time += delta
		$waterparticles.emitting = true
	else:
		time = max(0.0, time - delta)
		$waterparticles.emitting = false
	$timer.value = time
	$timer/line.rotation_degrees = remap(time, 0.0, 3.0, 0.0, 360.0)
	if time >= limit:
		if $cold.button_pressed:
			current_temp = global.INGREDIENTS.COLD
		else:
			current_temp = global.INGREDIENTS.HOT
		water_poured()

func highlight(outline : bool, btn):
	btn.material.set_shader_parameter("shader_enabled", outline)

func slide_tween(slide_in : bool):
	$"../maincontrol/ingredients/org".hide()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var y = 678.0 if slide_in else 1377.0
	tween.tween_property(self, "global_position:y", y, 0.5)
	await tween.finished
	_reset()

func water_poured():
	set_process(false)
	$waterparticles.emitting = false
	await get_tree().create_timer(0.15).timeout
	slide_tween(false)
	finished_pouring.emit(current_temp)

func _reset():
	set_process(true)
	time = 0.0
	
