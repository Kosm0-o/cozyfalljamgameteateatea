extends CanvasLayer

signal refresh_shop_items(tab_num : int)
signal start_new_day()

var current_shop_tab : int = 2

func _ready() -> void:
	$shop/X.mouse_entered.connect(highlight.bind(true, $shop/X))
	$shop/X.mouse_exited.connect(highlight.bind(false, $shop/X))

func money_tween(payment : int):
	money_gain_num(payment)
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_method(increase_money_text, global.money, global.money + payment, 0.3)

func increase_money_text(val : int):
	$money.text = "$" + str(val)
	global.money = val

func highlight(outline : bool, btn):
	btn.material.set_shader_parameter("shader_enabled", outline)

func _on_shoptabs_tab_changed(tab: int) -> void:
	current_shop_tab = tab
	refresh_shop_items.emit(tab)
	$shop/org.size.x = 0.0
	$shop/org.position.x = ($shop.size.x - $shop/org.size.x) + 38.0

func money_gain_num(gain : int):
	var moneynum = preload("res://scenes/moneynum.tscn").instantiate()
	add_child(moneynum)
	moneynum.global_position = $money.global_position + Vector2($money.size.x - (79.0 / 2) * len($money.text), $money.size.y)
	var sym = "-" if sign(gain) == -1 else "+"
	moneynum.text = sym + "$" + str(abs(gain))

func _on_x_pressed() -> void:
	$shop.hide()
	await eye_move(false)
	start_new_day.emit()

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
