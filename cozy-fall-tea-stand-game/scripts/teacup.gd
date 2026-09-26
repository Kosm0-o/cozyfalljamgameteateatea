extends Button

@onready var cup: Sprite2D = $".."

var ingredients : Array = [
	
]

func _ready() -> void:
	mouse_entered.connect(highlight.bind(true))
	mouse_exited.connect(highlight.bind(false))
	

func _on_pressed() -> void:
	if global.current_ingredient == global.INGREDIENTS.NONE: return
	ingredients.append(global.current_ingredient)
	global.current_ingredient = global.INGREDIENTS.NONE
	if global.current_type == global.TYPES.EXTRA:
		$"../../sendbtn".show()
		$"../../ingredients/org".hide()
	if global.current_type + 1 < global.TYPES.size():
		global.current_type = global.current_type + 1 as global.TYPES
	else:
		global.current_type = global.TYPES.TEA
	global.next_type.emit()
	print("ingredients: ", ingredients)

func highlight(outline : bool):
	cup.material.set_shader_parameter("shader_enabled", outline)
