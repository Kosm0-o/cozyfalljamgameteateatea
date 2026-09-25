extends Node2D

signal trigger_dialogue(txt : String)
signal dialogue_finished()

@onready var d: Control = $dialogue

var dialogue : String = "Hi mah name is freddy fazbeah"

func _ready() -> void:
	d.dialogue_finished.connect(func(): dialogue_finished.emit())

func _start():
	await get_tree().create_timer(0.5).timeout
	await slide_in_tween()
	trigger_dialogue.emit(dialogue)
	
func slide_in_tween():
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "global_position:x", 576.0, 0.6)
	await tween.finished

func connect_next_customer(game):
	game.next_customer.connect(_start)
