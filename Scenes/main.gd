extends Node2D
var is_stopwatch_running:bool = false
var stopwatch: float = 0.0
var minutes: int = 0
var hours: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%StopWatch.text = "00.00"
	%Minutes.text = "00"
	%Hours.text = "0"


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
			%StopWatch.text = str("00", stopwatch).pad_decimals(2)
		else:
			%StopWatch.text = str(stopwatch).pad_decimals(2)


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
