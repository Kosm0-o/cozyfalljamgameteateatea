extends Node2D

signal trigger_dialogue(txt : String)
signal dialogue_finished(times : int)

@onready var d: Control = $dialogue

var dialogue : String = "Hi mah name is freddy fazbeah"
var typical_dialogue : String = "Thank you for the tea!"
var secret_dialogue : String = "This reminds me of bonnie"
var desired_ingredients : Array = []

func _ready() -> void:
	d.dialogue_finished.connect(func(times): dialogue_finished.emit(times))
	for i in range(3):
		var possible : Array = []
		var all : Array = global.INGREDIENTS.values()
		for j in range(3):
			possible.append(i * 3 + j + 1)
		desired_ingredients.append(
			possible.pick_random()
		)
	print("desired: ", desired_ingredients)

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

func connect_camera_move(cam : Camera2D):
	$dialogue.cam = cam
	
