extends Button

var type = global.INGREDIENTS.NONE


func _ready() -> void:
	global.next_type.connect(_refresh)
	_refresh()

func _on_pressed() -> void:
	global.current_ingredient = type

func set_type(ingredients_of_type : Array):
	if "3" in name:
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
				global.INGREDIENTS.TEA3
			])
		global.TYPES.SWEETENER:
			set_type([
				global.INGREDIENTS.SWEETENER1,
				global.INGREDIENTS.SWEETENER2,
				global.INGREDIENTS.SWEETENER3
			])
		global.TYPES.EXTRA:
			set_type([
				global.INGREDIENTS.EXTRA1,
				global.INGREDIENTS.EXTRA2,
				global.INGREDIENTS.EXTRA3
			])
