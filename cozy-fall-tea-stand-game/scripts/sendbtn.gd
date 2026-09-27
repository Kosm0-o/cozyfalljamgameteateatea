extends Button

func _ready() -> void:
	mouse_entered.connect(highlight.bind(true))
	mouse_exited.connect(highlight.bind(false))

func _on_pressed() -> void:
	global.send_tea.emit()
	$"../ingredients/org".show()
	hide()

func highlight(outline : bool):
	material.set_shader_parameter("shader_enabled", outline)
