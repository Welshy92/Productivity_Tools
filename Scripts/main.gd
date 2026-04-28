extends Node2D
var is_stopwatch_running:bool = false
var stopwatch: float = 0.0
var minutes: int = 0
var hours: int = 0

enum window_states {Stopwatch, Notes}
var active_window: window_states = window_states.Stopwatch


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%StopWatch.text = "00.00"
	%Minutes.text = "00"
	%Hours.text = "0"
	%StopwatchIcon.modulate = Color(0.0, 0.294, 0.294, 1.0)
	load_notes()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_stopwatch_running == true:
		stopwatch += delta
	
	if hours > 99:
		on_reset_pressed()

	if stopwatch > 60:
		stopwatch -= 60
		minutes += 1
	if minutes == 60:
		minutes = 0
		hours += 1
		%Hours.text= str(hours)
		%Minutes.text = str(minutes)
	elif minutes < 10:
		%Minutes.text = str("00", minutes)
	else:
		%Minutes.text = str(minutes)
		
	if stopwatch < 10:
		%StopWatch.text = str("0", stopwatch).pad_decimals(2)
	else:
		%StopWatch.text = str(stopwatch).pad_decimals(2)

## The state changes when a nav bar button is pressed. It will firstly make all
## the different windows not visible and then find the correct window to show.
func changeState(window):
	print("Old active window = ", active_window)
	active_window = window
	print("New active window = ", active_window)
	%Stopwatch.visible = false
	%Start.disabled = true
	%Stop.disabled = true
	%Reset.disabled = true
	%StopwatchIcon.modulate = Color(1.0, 1.0, 1.0, 1.0)
	%Notes.visible = false
	%NoteTaking.editable = false
	%NoteIcon.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	if active_window == window_states.Stopwatch:
		%Title.text = "[center][b][u]Stopwatch"
		%Stopwatch.visible = true
		%Start.disabled = false
		%Stop.disabled = false
		%Reset.disabled = false
		%StopwatchIcon.modulate = Color(0.0, 0.294, 0.294, 1.0)

	elif active_window == window_states.Notes:
		%Title.text = "[center][b][u]Note Taking"
		%Notes.visible = true
		%NoteTaking.editable = true
		%NoteIcon.modulate = Color(0.0, 0.294, 0.294, 1.0)


func load_notes():
	var notes_content: String = NoteSaveAndLoad.loadGame()
	print("notes content = ", notes_content)
	%NoteTaking.text = notes_content


func _on_start_pressed() -> void:
	is_stopwatch_running = true


func _on_stop_pressed() -> void:
	is_stopwatch_running = false


func on_reset_pressed() -> void:
	is_stopwatch_running = false
	stopwatch = 0.0
	minutes = 0
	hours = 0
	%StopWatch.text = "00.00"
	%Minutes.text = "00"
	%Hours.text = "0"


func _on_window_close_requested() -> void:
	get_tree().quit()


func _on_stopwatch_nav_pressed() -> void:
	changeState(window_states.Stopwatch)

func _on_notes_nav_pressed() -> void:
	changeState(window_states.Notes)


func _on_save_notes_pressed() -> void:
	var notes_content: String = %NoteTaking.text
	
	NoteSaveAndLoad.saveGame(notes_content)
