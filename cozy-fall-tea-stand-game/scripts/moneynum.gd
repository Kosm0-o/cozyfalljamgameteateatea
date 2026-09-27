extends Label

func _ready() -> void:
	label_settings = label_settings.duplicate()
	rotation_degrees = randf_range(-45.0, 45.0)
	await get_tree().create_timer(0.7).timeout
	queue_free()
	
func _process(delta: float) -> void:
	label_settings.font_size -= delta * 2
	label_settings.font_color.a -= delta / 2
	position.y += delta * 250
	rotation_degrees += delta * 250
	if label_settings.font_size <= 0.0 or label_settings.font_color.a <= 0.0: queue_free()
