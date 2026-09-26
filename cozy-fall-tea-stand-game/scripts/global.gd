extends Node

signal next_type()
signal send_tea()

enum INGREDIENTS {
	NONE,
	TEA1,
	TEA2,
	TEA3,
	SWEETENER1,
	SWEETENER2,
	SWEETENER3,
	EXTRA1,
	EXTRA2,
	EXTRA3
}

enum TYPES {
	TEA,
	SWEETENER,
	EXTRA
}

var current_ingredient : INGREDIENTS = INGREDIENTS.NONE
var current_type : TYPES = TYPES.TEA
var current_customer : Node2D = null
