extends Node2D

signal next_customer()
signal camera_move()

@onready var cam: Camera2D = $Camera2D
@onready var teacup: Sprite2D = $maincontrol/teacup
@onready var cupbtn: Button = $maincontrol/teacup/btn

var correct_ingredients : int = 0


func _ready() -> void:
	global.send_tea.connect(_send_tea)
	next_customer.connect(func(): cupbtn.ingredients.clear())
	create_new_customer()
	next_customer.emit()
	camera_tween(true)
	

func create_new_customer():
	var customer = preload("res://scenes/customer.tscn").instantiate()
	add_child(customer)
	customer.global_position = Vector2(-137.0, 409.0)
	customer.connect_next_customer(self)
	customer.connect_camera_move($Camera2D)
	customer.dialogue_finished.connect(func(times : int):
		if times == 1:
			camera_tween(false)
		)
	global.current_customer = customer
	correct_ingredients = 0

func camera_tween(up : bool):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var pos = Vector2(576.0, 324.0) if up else Vector2(576.0, 648.0)
	tween.tween_property(cam, "global_position", pos, 0.4)
	await tween.finished

func _send_tea():
	await camera_tween(true)
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(teacup, "global_position:y", 465.0, 0.7)
	await tween.finished
	await check_ingredients()
	teacup.hide()
	teacup.global_position = Vector2(-326.0, 589.0)
	await send_off_customer()
	teacup.show()
	var tween2 = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween2.tween_interval(0.1)
	tween2.tween_property(teacup, "global_position:x", 583.0, 0.7)
	await tween2.finished
	create_new_customer()
	next_customer.emit()

func send_off_customer():
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(global.current_customer, "global_position:x", 1500.0, 0.6)
	await tween.finished
	global.current_customer.queue_free()
	global.current_customer = null

func check_ingredients():
	var ingredients = cupbtn.ingredients
	var desired = global.current_customer.desired_ingredients
	for i in ingredients:
		if i in desired:
			correct_ingredients += 1
	global.current_customer.trigger_dialogue.emit(
		global.current_customer.secret_dialogue if correct_ingredients == 3 else global.current_customer.typical_dialogue
	)
	await global.current_customer.dialogue_finished
	
