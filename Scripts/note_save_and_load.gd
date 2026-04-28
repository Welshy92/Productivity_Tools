extends Node

# Use users instead of res on proper game release to have save game file
# outside of the games directory.
const SAVE_PATH:String = "user://notesforproductivity.txt"
var notes_content: String

func saveGame(data) -> void:
	print("date = ", data)
# Allow write access to the save file.
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	print(file)

# Set the data that needs to be saved in this dictionary.
	file.store_string(data)
	
	file.close()


func loadGame() -> String:
# Allow read access to the save file adn the read it line by line.
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	print(file)
# Only try to read the file if it exists.
	if FileAccess.file_exists(SAVE_PATH) == true:
		notes_content = file.get_as_text()
		
		file.close()
	
	return notes_content
