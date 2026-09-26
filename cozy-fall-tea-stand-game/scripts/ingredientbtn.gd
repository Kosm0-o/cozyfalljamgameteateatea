extends Button

var type = global.INGREDIENTS.NONE


func _ready() -> void:
	global.next_type.connect(_refresh)
	_refresh()

func _on_pressed() -> void:
	global.current_ingredient = type

func set_type(ingredients_of_type : Array):
	if "6" in name:
		if ingredients_of_type[5] in global.unlocked_ingredients:
			type = ingredients_of_type[5]
			show()
		else:
			hide()
	elif "5" in name:
		if ingredients_of_type[4] in global.unlocked_ingredients:
			type = ingredients_of_type[4]
			show()
		else:
			hide()
	elif "4" in name:
		if ingredients_of_type[3] in global.unlocked_ingredients:
			type = ingredients_of_type[3]
			show()
		else:
			hide()
	elif "3" in name:
		type = ingredients_of_type[2]
	elif "2" in name:
		type = ingredients_of_type[1]
	else:
		type = ingredients_of_type[0]
	
	text = global.INGREDIENTS.keys()[type]

func _refresh():
	match global.current_type:
		global.TYPES.TEA:
			set_type([
				global.INGREDIENTS.TEA1,
				global.INGREDIENTS.TEA2,
				global.INGREDIENTS.TEA3,
				global.INGREDIENTS.TEA4,
				global.INGREDIENTS.TEA5,
				global.INGREDIENTS.TEA6
			])
		global.TYPES.SWEETENER:
			set_type([
				global.INGREDIENTS.SWEETENER1,
				global.INGREDIENTS.SWEETENER2,
				global.INGREDIENTS.SWEETENER3,
				global.INGREDIENTS.SWEETENER4,
				global.INGREDIENTS.SWEETENER5,
				global.INGREDIENTS.SWEETENER6
			])
		global.TYPES.EXTRA:
			set_type([
				global.INGREDIENTS.EXTRA1,
				global.INGREDIENTS.EXTRA2,
				global.INGREDIENTS.EXTRA3,
				global.INGREDIENTS.EXTRA4,
				global.INGREDIENTS.EXTRA5,
				global.INGREDIENTS.EXTRA6
			])
