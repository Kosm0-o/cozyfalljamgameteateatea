extends Button

var cost : int = 10
var ingredient
@onready var ui: CanvasLayer = $"../../.."
var bought : Array[bool] = [
	false,
	false,
	false
]
@export var item_datas : Dictionary = {
	"extra": {
		"name": "EXTRA4",
		"cost": 20,
		"ingredient": global.INGREDIENTS.EXTRA4
	},
	"sweetener": {
		"name": "SWEETENER4",
		"cost": 15,
		"ingredient": global.INGREDIENTS.SWEETENER4
	},
	"tea": {
		"name": "TEA4",
		"cost": 10,
		"ingredient": global.INGREDIENTS.TEA4
	}
}

func _ready() -> void:
	ui.refresh_shop_items.connect(_refresh)
	_refresh(2)

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
	text = data.name + "\n cost: " + str(data.cost)
	cost = data.cost
	ingredient = data.ingredient
