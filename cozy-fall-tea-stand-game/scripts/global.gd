extends Node

signal next_type()
signal send_tea()

enum INGREDIENTS {
	NONE,
	TEA1,
	TEA2,
	TEA3,
	TEA4,
	TEA5,
	TEA6,
	SWEETENER1,
	SWEETENER2,
	SWEETENER3,
	SWEETENER4,
	SWEETENER5,
	SWEETENER6,
	EXTRA1,
	EXTRA2,
	EXTRA3,
	EXTRA4,
	EXTRA5,
	EXTRA6
}

enum TYPES {
	TEA,
	SWEETENER,
	EXTRA
}

var clues : Dictionary = {
	
}

var order_dialogue_templates : Dictionary = {
	"polite": [
		[
			"I'd like something ",
			", with a little ",
			". Maybe something ",
			" and nice and ",
			"."
		],
		[
			"Could I have something ",
			"? I'd like it ",
			", with a touch of ",
			". And please make it ",
			"."
		],
		[
			"Something ",
			" sounds nice. I'd also like a little ",
			" and ",
			". I'd prefer it ",
			"."
		],
		[
			"I'd love something ",
			", ",
			", and ",
			". And could you make it ",
			"?"
		],
		[
			"I think I'll have something ",
			" today, with some ",
			" and ",
			". ",
			" would be perfect."
		],
		[
			"Something ", 
			" with ",
			" and ",
			", please. And not too far from ",
			"."
		],
		[
			"Would you be a darling and make something ",
			" with a bit of ",
			" and ",
			". Don't forget to keep it ",
			"."
		],
		[
			"Could you make me something ",
			", with a hint of ",
			" and ",
			"? I'd like it ",
			"."
		]
	],
	"cheerful": []
}

var current_ingredient : INGREDIENTS = INGREDIENTS.NONE
var current_type : TYPES = TYPES.TEA
var current_customer : Node2D = null
var money : int = 1000
var unlocked_ingredients : Array[INGREDIENTS] = [
	INGREDIENTS.TEA1,
	INGREDIENTS.TEA2,
	INGREDIENTS.TEA3,
	INGREDIENTS.SWEETENER1,
	INGREDIENTS.SWEETENER2,
	INGREDIENTS.SWEETENER3,
	INGREDIENTS.EXTRA1,
	INGREDIENTS.EXTRA2,
	INGREDIENTS.EXTRA3
]
