extends Node2D

signal next_customer()
signal camera_move()

@onready var cam: Camera2D = $Camera2D
@onready var teacup: Sprite2D = $maincontrol/teacup
@onready var cupbtn: Button = $maincontrol/teacup/btn
@onready var sky: ColorRect = $bg/sky



var correct_ingredients : int = 0
var customers_served : int = 0
var customers_per_day : int = 3
var saved_customers_served : int = 0


func _ready() -> void:
	global.send_tea.connect(_send_tea)
	$ui.start_new_day.connect(_start_day)
	global.next_type.connect(func():
		await _slide_ingredients(false)
		await _slide_ingredients(true)
		)
	$watermachine.finished_pouring.connect(
		func(temp):
			$maincontrol/sendbtn.show()
			cupbtn.ingredients.append(temp)
			cupbtn.show_liquid()
			cupbtn.insert_water_tween(false)
			)
	next_customer.connect(func(): cupbtn.ingredients.clear())
	await $ui.eye_move(false)
	_start_day()
	await camera_tween(true)
	for btn in $maincontrol/ingredients/org.get_children():
		btn.disabled = false

func _process(delta: float) -> void:
	$sunpath/sunpos.progress_ratio = lerpf($sunpath/sunpos.progress_ratio, float(customers_served) / float(customers_per_day), 2 * delta)
	lerp_light_rays(delta)
	
func create_new_customer():
	var customer = preload("res://scenes/customer.tscn").instantiate()
	if saved_customers_served < global.saved_customers.size():
		customer.input_stats = global.saved_customers[saved_customers_served]
	if not customer.input_stats in global.saved_customers:
		global.customer_queue.append(customer.stats)
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
	tween.tween_property(teacup, "global_position:y", 480.0, 0.7)
	await tween.finished
	await check_ingredients()
	teacup.hide()
	teacup.global_position = Vector2(-326.0, 589.0)
	await get_tree().create_timer(1.5).timeout
	await send_off_customer()
	customers_served += 1
	if saved_customers_served < global.saved_customers.size():
		saved_customers_served += 1
	cupbtn.liquid.hide()
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
	if correct_ingredients == 4:
		global.current_customer.trigger_dialogue.emit(global.current_customer.secret_dialogue)
		global.current_customer.stats.secret_story_num += 1
	else:
		global.current_customer.trigger_dialogue.emit(global.current_customer.typical_dialogue)
	await global.current_customer.dialogue_finished
	var payment = (randi_range(1, 3) + correct_ingredients) * correct_ingredients
	payment = payment if payment > 0 else randi_range(1, 2)
	$ui.money_tween(payment)


func end_day():
	await $ui.eye_move(true)
	$ui/shop.show()
	customers_per_day += randi_range(1, 2)
	customers_served = 0
	$sunpath/sunpos.progress_ratio = 0.0
	global.saved_customers.append_array(global.customer_queue)

func _start_day():
	for btn in $maincontrol/ingredients/org.get_children():
		btn._refresh()
	create_new_customer()
	next_customer.emit()

func lerp_light_rays(delta : float):
	var angle = $lightrays.material.get_shader_parameter("angle")
	var pos = $lightrays.material.get_shader_parameter("position")
	var skytop = sky.material.get_shader_parameter("color_zenith")
	var skybottom = sky.material.get_shader_parameter("color_horizon")
	var new_angle
	var new_pos
	var new_sky_top
	var new_sky_bottom
	if $sunpath/sunpos.progress_ratio < 0.25:
		new_angle = lerpf(angle, -0.695, 3 * delta)
		new_pos = lerpf(pos, -5.505, 3 * delta)
		new_sky_top = lerp(skytop, Color("0091b5"), 3 * delta)
		new_sky_bottom = lerp(skybottom, Color("180026"), 3 * delta)
	elif $sunpath/sunpos.progress_ratio < 0.5:
		new_angle = lerpf(angle, -0.025, 3 * delta)
		new_pos = lerpf(pos, 0.07, 3 * delta)
		new_sky_top = lerp(skytop, Color("00cafa"), 3 * delta)
		new_sky_bottom = lerp(skybottom, Color("005aa6"), 3 * delta)
	elif $sunpath/sunpos.progress_ratio < 0.75:
		new_angle = lerpf(angle, 0.475, 3 * delta)
		new_pos = lerpf(pos, 0.275, 3 * delta)
		new_sky_top = lerp(skytop, Color("00a7f9"), 3 * delta)
		new_sky_bottom = lerp(skybottom, Color("1900ff"), 3 * delta)
	else:
		new_angle = lerpf(angle, 1.135, 3 * delta)
		new_pos = lerpf(pos, 0.495, 3 * delta)
		new_sky_top = lerp(skytop, Color("b13600"), 3 * delta)
		new_sky_bottom = lerp(skybottom, Color("500064"), 3 * delta)
	$lightrays.material.set_shader_parameter("angle", new_angle)
	$lightrays.material.set_shader_parameter("position", new_pos)
	sky.material.set_shader_parameter("color_horizon", new_sky_bottom)
	sky.material.set_shader_parameter("color_zenith", new_sky_top)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		await $ui.eye_move(true)
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _slide_ingredients(slide_in : bool):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($maincontrol/ingredients/org, "global_position:y", 691.0 if slide_in else 1321.0, 0.7)
	await tween.finished
