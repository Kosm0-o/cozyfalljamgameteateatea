extends PanelContainer


func _ready() -> void:
	var empty = StyleBoxEmpty.new()
	ThemeDB.get_default_theme().set_stylebox("panel", "TooltipPanel", empty)

func setup(ingredient_name : String, description : String, color : Color):
	var title: Label = $MarginContainer/VBoxContainer/title
	var desc: Label = $MarginContainer/VBoxContainer/desc
	title.text = ingredient_name
	title.label_settings.font_color = color
	desc.text = description
