extends Node2D

signal next_customer()
signal camera_move()

@onready var cam: Camera2D = $Camera2D
@onready var teacup: Sprite2D = $maincontrol/teacup
@onready var cupbtn: Button = $maincontrol/teacup/btn

var correct_ingredients : int = 0
var customers_served : int = 0
var customers_per_day : int = 3


func _ready() -> void:
	global.send_tea.connect(_send_tea)
	$ui.start_new_day.connect(_start_day)
	next_customer.connect(func(): cupbtn.ingredients.clear())
	_start_day()
	camera_tween(true)

func _process(delta: float) -> void:
	$sunpath/sunpos.progress_ratio = lerpf($sunpath/sunpos.progress_ratio, float(customers_served) / float(customers_per_day), 2 * delta)
	
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
	customers_served += 1
	teacup.show()
	var tween2 = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween2.tween_interval(0.1)
	tween2.tween_property(teacup, "global_position:x", 583.0, 0.7)
	await tween2.finished
	if customers_served == customers_per_day:
		end_day()
	else:
		_start_day()

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
	var payment = (randi_range(1, 3) + correct_ingredients) * correct_ingredients
	payment = payment if payment > 0 else randi_range(1, 2)
	$ui.money_tween(payment)


func end_day():
	$ui/shop.show()
	customers_per_day += randi_range(1, 2)
	customers_served = 0
	$sunpath/sunpos.progress_ratio = 0.0

func _start_day():
	for btn in $maincontrol/ingredients/org.get_children():
		btn._refresh()
	create_new_customer()
	next_customer.emit()
