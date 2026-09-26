extends CanvasLayer

signal refresh_shop_items(tab_num : int)
signal start_new_day()

var current_shop_tab : int = 2

func money_tween(payment : int):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_method(increase_money_text, global.money, global.money + payment, 0.3)

func increase_money_text(val : int):
	$money.text = "$" + str(val)
	global.money = val


func _on_shoptabs_tab_changed(tab: int) -> void:
	refresh_shop_items.emit(tab)
	$shop/org.size.x = 0.0
	$shop/org.position.x = ($shop.size.x - $shop/org.size.x) / 2


func _on_x_pressed() -> void:
	$shop.hide()
	start_new_day.emit()
