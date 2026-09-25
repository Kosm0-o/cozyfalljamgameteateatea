extends Button

@export var type = global.INGREDIENTS.NONE


func _ready() -> void:
	text = global.INGREDIENTS.keys()[type]

func _on_pressed() -> void:
	global.current_ingredient = type
