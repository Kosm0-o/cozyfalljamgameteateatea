extends Button

var ingredients : Array = [
	
]

func _on_pressed() -> void:
	if global.current_ingredient == global.INGREDIENTS.NONE: return
	ingredients.append(global.current_ingredient)
	global.current_ingredient = global.INGREDIENTS.NONE
	print(ingredients)
