extends Node2D
var is_stopwatch_running:bool = false
var stopwatch: float = 0.0
var minutes: int = 0
var hours: int = 0
var decimal_enabled = true

enum window_states {Stopwatch, Notes, Calculator, Timerapp, About}
var active_window: window_states = window_states.Stopwatch


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%StopWatch.text = "00.00"
	%Minutes.text = "00"
	%Hours.text = "0"
	%StopwatchIcon.modulate = Color(0.0, 0.294, 0.294, 1.0)
	load_notes()
	DisplayServer.window_set_position(Vector2i(0,0), 0)
	DisplayServer.window_set_size(Vector2i(0,0), 0)


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
## You need to parse "window_states.STATENAME" for the function to work.
func changeState(window):
	active_window = window
	
	#Remove Stopwatch
	%Stopwatch.visible = false
	%StopwatchIcon.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	#Remove Notes
	%Notes.visible = false
	%NoteTaking.editable = false
	%NoteIcon.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	#Remove Calculator
	%Calculator.visible = false
	%CalculatorIcon.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	#Remove About
	%About.visible = false
	%LinkButton.disabled = true
	
	
	if active_window == window_states.Stopwatch:
		%Title.text = "[center][b][u]Stopwatch"
		%Stopwatch.visible = true
		%StopwatchIcon.modulate = Color(0.0, 0.294, 0.294, 1.0)

	elif active_window == window_states.Notes:
		%Title.text = "[center][b][u]Note Taking"
		%Notes.visible = true
		%NoteTaking.editable = true
		%NoteIcon.modulate = Color(0.0, 0.294, 0.294, 1.0)
		
	elif active_window == window_states.Calculator:
		%Title.text = "[center][b][u]Calculator"
		%Calculator.visible = true
		%NoteIcon.modulate = Color(0.0, 0.294, 0.294, 1.0)

	elif active_window == window_states.Timerapp:
		%Title.text = "[center][b][u]Timer"
	
	elif active_window == window_states.About:
		%Title.text = "[center][b][u]About"
		%About.visible = true
		%LinkButton.disabled = false
		%AboutIcon.modulate = Color(0.0, 0.294, 0.294, 1.0)



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


func _on_calculator_nav_pressed() -> void:
	changeState(window_states.Calculator)


func _on_about_nav_pressed() -> void:
	changeState(window_states.About)


func _on_save_notes_pressed() -> void:
	var notes_content: String = %NoteTaking.text
	
	NoteSaveAndLoad.saveGame(notes_content)
