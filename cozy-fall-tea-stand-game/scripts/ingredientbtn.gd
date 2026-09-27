extends Button

var type = global.INGREDIENTS.NONE

var textures : Array = [
	preload("res://assets/Matcha Bag.svg"),
	preload("res://assets/Chamomile Bag.svg"),
	preload("res://assets/Oolong Bag.svg"),
	preload("res://assets/Hibiscus Bag.svg"),
	preload("res://assets/Chai Bag.svg"),
	preload("res://assets/Earl Grey Bag.svg"),
	preload("res://assets/Sugar.svg"),
	preload("res://assets/Honey.svg"),
	preload("res://assets/Maple Syrup (3).svg"),
	preload("res://assets/Agave Nectar.svg"),
	preload("res://assets/Molasses.svg"),
	preload("res://assets/Apple Juice.svg"),
	preload("res://assets/Lemon.svg"),
	preload("res://assets/Milk (2).svg"),
	preload("res://assets/Cinnamon.svg"),
	preload("res://assets/mint.svg"),
	preload("res://assets/Ginger.svg"),
	preload("res://assets/Cucumber.svg")
]

var checked : bool = false

func _ready() -> void:
	global.next_type.connect(_refresh)
	material = material.duplicate()
	mouse_entered.connect(highlight.bind(true))
	mouse_exited.connect(highlight.bind(false))
	_refresh()

func _on_pressed() -> void:
	global.current_ingredient = type

func _process(delta: float) -> void:
	if global.current_ingredient == type:
		material.set_shader_parameter("shader_enabled", true)
		checked = false
	elif global.current_ingredient != type and not checked:
		material.set_shader_parameter("shader_enabled", false)
		checked = true

func highlight(outline : bool):
	material.set_shader_parameter("shader_enabled", outline)

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
	var num = int(str(name)[3]) + global.current_type * 6
	if num <= textures.size():
		icon = textures[num - 1]
		text = ""
		flat = true
	else:
		text = global.INGREDIENTS.keys()[type]
		icon = null
		flat = false

func _refresh():
	await get_tree().create_timer(0.35).timeout
	match global.current_type:
		global.TYPES.TEA:
			set_type([
				global.INGREDIENTS.MATCHA,
				global.INGREDIENTS.CHAMOMILE,
				global.INGREDIENTS.OOLONG,
				global.INGREDIENTS.HIBISCUS,
				global.INGREDIENTS.CHAI,
				global.INGREDIENTS.EARLGREY
			])
		global.TYPES.SWEETENER:
			set_type([
				global.INGREDIENTS.SUGAR,
				global.INGREDIENTS.HONEY,
				global.INGREDIENTS.MAPLESYRUP,
				global.INGREDIENTS.AGAVENECTAR,
				global.INGREDIENTS.MOLASSES,
				global.INGREDIENTS.APPLEJUICE
			])
		global.TYPES.EXTRA:
			set_type([
				global.INGREDIENTS.LEMON,
				global.INGREDIENTS.MILK,
				global.INGREDIENTS.CINNAMON,
				global.INGREDIENTS.MINT,
				global.INGREDIENTS.GINGER,
				global.INGREDIENTS.CUCUMBER
			])

func _make_custom_tooltip(for_text: String) -> Object:
	var tooltip = preload("res://scenes/customtooltip.tscn").instantiate()
	var ing = global.INGREDIENTS.keys()[type]
	tooltip.setup(
		ing,
		global.ingredient_descriptions[ing.to_lower()],
		global.ingredient_colors[ing.to_lower()]
	)
	return tooltip
