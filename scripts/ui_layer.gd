extends CanvasLayer

class_name UILayer

var characters_label: Label

func populate_characters_label(character_list: Array[Character]):
	characters_label = $DebugList/Characters
	characters_label.text = "Order / Name / HP:\n"
	
	var i: int = 1
	for character: Character in character_list:
		characters_label.text += str(i) + ". " + character.character_name + " - " + str(character.health) + "\n"
		i += 1

func get_debug_list():
	return $DebugList
