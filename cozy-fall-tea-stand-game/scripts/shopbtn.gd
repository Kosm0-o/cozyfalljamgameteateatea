extends Button

var cost : int = 10
var ingredient
@onready var ui: CanvasLayer = $"../../.."
@onready var itemlbl: Label = $Label2
@onready var costlbl: Label = $Label3


var bought : Array[bool] = [
	false,
	false,
	false
]
@export var item_datas : Dictionary = {
	"extra": {
		"name": "MINT",
		"cost": 20,
		"ingredient": global.INGREDIENTS.MINT
	},
	"sweetener": {
		"name": "AGAVENECTAR",
		"cost": 15,
		"ingredient": global.INGREDIENTS.AGAVENECTAR
	},
	"tea": {
		"name": "HIBISCUS",
		"cost": 10,
		"ingredient": global.INGREDIENTS.HIBISCUS
	}
}

func _ready() -> void:
	material = material.duplicate()
	ui.refresh_shop_items.connect(_refresh)
	_refresh(2)
	mouse_entered.connect(highlight.bind(true))
	mouse_exited.connect(highlight.bind(false))

func highlight(outline : bool):
	material.set_shader_parameter("shader_enabled", outline)

func _on_pressed() -> void:
	if global.money >= cost:
		ui.money_tween(-cost)
		hide()
		bought[ui.current_shop_tab] = true
		print("shoptab: ", ui.current_shop_tab, " bought: ", bought)
		global.unlocked_ingredients.append(ingredient)

func _refresh(tab_num : int):
	if bought[tab_num]:
		hide()
	else:
		show()
	var data : Dictionary = item_datas[item_datas.keys()[tab_num]]
	itemlbl.text = data.name
	costlbl.text = "$" + str(data.cost)
	cost = data.cost
	ingredient = data.ingredient
