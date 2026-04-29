extends Node2D

var current_sum: String = ""
var display_sum: String = ""
var sum_completed: bool = false


func updateSum() -> void:
	%CalcDisplay.text = display_sum
	print(current_sum)
	
	if sum_completed == true:
		current_sum = ""
		display_sum = ""
		sum_completed = false


func _on_button_1_pressed() -> void:
	display_sum = str(display_sum + "1")
	current_sum = str(current_sum + "1")
	updateSum()


func _on_button_2_pressed() -> void:
	display_sum = str(display_sum + "2")
	current_sum = str(current_sum + "2")
	updateSum()


func _on_button_3_pressed() -> void:
	display_sum = str(display_sum + "3")
	current_sum = str(current_sum + "3")
	updateSum()


func _on_button_4_pressed() -> void:
	display_sum = str(display_sum + "4")
	current_sum = str(current_sum + "4")
	updateSum()


func _on_button_5_pressed() -> void:
	display_sum = str(display_sum + "5")
	current_sum = str(current_sum + "5")
	updateSum()


func _on_button_6_pressed() -> void:
	display_sum = str(display_sum + "6")
	current_sum = str(current_sum + "6")
	updateSum()


func _on_button_7_pressed() -> void:
	display_sum = str(display_sum + "7")
	current_sum = str(current_sum + "7")
	updateSum()


func _on_button_8_pressed() -> void:
	display_sum = str(display_sum + "8")
	current_sum = str(current_sum + "8")
	updateSum()


func _on_button_9_pressed() -> void:
	display_sum = str(display_sum + "9")
	current_sum = str(current_sum + "9")
	updateSum()


func _on_button_0_pressed() -> void:
	display_sum = str(display_sum + "0")
	current_sum = str(current_sum + "0")
	updateSum()


func _on_button_plus_pressed() -> void:
	display_sum = str(display_sum + "+")
	current_sum = str(current_sum + "+")
	updateSum()


func _on_button_minus_pressed() -> void:
	display_sum = str(display_sum + "-")
	current_sum = str(current_sum + "-")
	updateSum()


func _on_button_multiply_pressed() -> void:
	display_sum = str(display_sum + "x")
	current_sum = str(current_sum + "*")
	updateSum()


func _on_button_divide_pressed() -> void:
	display_sum = str(display_sum + "÷")
	current_sum = str(current_sum + "/")
	updateSum()


func _on_button_equals_pressed() -> void:
	
	var parse_sum: String = current_sum
	if current_sum.contains("/") and not current_sum.contains("."):
		parse_sum = str(current_sum + ".0")
	else:
		parse_sum = current_sum
	print("Parse sum =   ", parse_sum)
	var expression: Expression = Expression.new()
	expression.parse(parse_sum)
	var result: float = expression.execute()
	
	display_sum = String.num(result, 4)
	current_sum = str(result)
	sum_completed = true
	updateSum()

func _on_button_clear_pressed() -> void:
	display_sum = ""
	current_sum = ""
	updateSum()


func _on_button_decimal_pressed() -> void:
	display_sum = str(display_sum + ".")
	current_sum = str(current_sum + ".")
	updateSum()
