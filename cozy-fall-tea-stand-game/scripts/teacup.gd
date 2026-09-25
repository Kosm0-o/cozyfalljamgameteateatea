extends Button

var ingredients : Array = [
	
]

func _on_pressed() -> void:
	ingredients.append(global.current_ingredient)
	global.current_ingredient = global.INGREDIENTS.NONE
	print(ingredients)
