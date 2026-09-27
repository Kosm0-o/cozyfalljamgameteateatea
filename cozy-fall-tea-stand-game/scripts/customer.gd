extends Node2D

signal trigger_dialogue(txt : String)
signal dialogue_finished(times : int)

@onready var d: Control = $dialogue

var dialogue : String = "Hi mah name is freddy fazbeah"
var typical_dialogue : String = "Thank you for the tea!"
var secret_dialogue : String = "This reminds me of bonnie"
var desired_ingredients : Array = []
var stats : Dictionary = {
	"name": global.customer_names.pick_random(),
	"personality": global.order_dialogue_templates.keys().pick_random(),
	"job": global.job_secret_dialogue_templates.keys().pick_random(),
	"hobby": global.hobby_secret_dialogue_templates.keys().pick_random(),
	"job_or_hobby": ["job", "hobby"].pick_random(),
	"secret_story_num": 0,
	"torso": str(randi_range(1, 5)),
	"head": str(randi_range(1, 6))
}
var input_stats : Dictionary = {}

func _ready() -> void:
	if not input_stats.is_empty():
		stats = input_stats
	$sprite/torso.play(stats.torso)
	$sprite/head.play(stats.head)
	d.dialogue_finished.connect(func(times): dialogue_finished.emit(times))
	for i in range(4):
		var possible : Array = []
		if i == 0:
			for val in global.unlocked_ingredients:
				if val <= 6:
					possible.append(val)
		elif i == 3:
			possible.append(global.INGREDIENTS.HOT)
			possible.append(global.INGREDIENTS.COLD)
		else:
			for j in range(6):
				possible.append(i * 6 + j + 1)
		desired_ingredients.append(
			possible.pick_random()
		)
	print("desired: ", desired_ingredients)
	if "job" in stats["job_or_hobby"]:
		secret_dialogue = global.job_secret_dialogue_templates[stats.job][stats.personality][stats["secret_story_num"]]
	else:
		secret_dialogue = global.hobby_secret_dialogue_templates[stats.hobby][stats.personality][stats["secret_story_num"]]
	if stats.secret_story_num == 0:
		secret_dialogue += " I'm " + stats.name + " by the way."
	typical_dialogue = global.typical_dialogue.pick_random()

func _start():
	await get_tree().create_timer(0.5).timeout
	await slide_in_tween()
	var template_options = global.order_dialogue_templates[stats.personality]
	var template = template_options.pick_random()
	var tea = global.INGREDIENTS.keys()[desired_ingredients[0]]
	var teaword = global.tea_clues[tea.to_lower()].pick_random()
	var sweet = global.INGREDIENTS.keys()[desired_ingredients[1]]
	var sweetword = global.sweetener_clues[sweet.to_lower()].pick_random()
	var extra = global.INGREDIENTS.keys()[desired_ingredients[2]]
	var extraword = global.extra_clues[extra.to_lower()].pick_random()
	var temp = global.INGREDIENTS.keys()[desired_ingredients[3]]
	var tempword = global.temperature_clues[temp.to_lower()].pick_random()
	dialogue = template[0] + teaword + template[1] + sweetword + template[2] + extraword + template[3] + tempword + template[4]
	trigger_dialogue.emit(dialogue)
	
func slide_in_tween():
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "global_position:x", 576.0, 1.5)
	await tween.finished

func connect_next_customer(game):
	game.next_customer.connect(_start)

func connect_camera_move(cam : Camera2D):
	$dialogue.cam = cam
	
