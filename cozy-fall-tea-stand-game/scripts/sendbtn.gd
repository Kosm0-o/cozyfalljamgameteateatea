extends Button

func _on_pressed() -> void:
	global.send_tea.emit()
	$"../ingredients/org".show()
	hide()
