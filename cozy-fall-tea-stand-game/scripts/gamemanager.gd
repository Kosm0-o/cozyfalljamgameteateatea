extends Node2D

signal next_customer()

@onready var cam: Camera2D = $Camera2D

func _ready() -> void:
	create_new_customer()
	next_customer.emit()
	camera_tween(true)
	

func create_new_customer():
	var customer = preload("res://scenes/customer.tscn").instantiate()
	add_child(customer)
	customer.global_position = Vector2(-137.0, 409.0)
	customer.connect_next_customer(self)
	customer.dialogue_finished.connect(camera_tween.bind(false))

func camera_tween(up : bool):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var pos = Vector2(576.0, 324.0) if up else Vector2(576.0, 648.0)
	tween.tween_property(cam, "global_position", pos, 0.4)
