extends Button

@onready var cup: Sprite2D = $".."
@onready var liquid: AnimatedSprite2D = $"../liquid"

var ingredients : Array = [
	
]

func _ready() -> void:
	mouse_entered.connect(highlight.bind(true))
	mouse_exited.connect(highlight.bind(false))
	get_parent().global_position = Vector2(590.0, 589.0)
	

func _on_pressed() -> void:
	if global.current_ingredient == global.INGREDIENTS.NONE: return
	ingredients.append(global.current_ingredient)
	global.current_ingredient = global.INGREDIENTS.NONE
	if global.current_type == global.TYPES.EXTRA:
		await $"../../../watermachine".slide_tween(true)
		insert_water_tween(true)
	if global.current_type + 1 < global.TYPES.size() - 1:
		global.current_type = global.current_type + 1 as global.TYPES
	else:
		global.current_type = global.TYPES.TEA
	global.next_type.emit()
	print("ingredients: ", ingredients)

func highlight(outline : bool):
	cup.material.set_shader_parameter("shader_enabled", outline)

func insert_water_tween(to_dispenser : bool):
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	var pos = Vector2(914.0, 849.0) if to_dispenser else Vector2(590.0, 589.0)
	tween.tween_property(get_parent(), "global_position", pos, 0.5)
	await tween.finished

func show_liquid():
	$"../liquid".show()
	var tea = global.INGREDIENTS.keys()[ingredients[0]]
	$"../liquid".play(tea.to_lower())
