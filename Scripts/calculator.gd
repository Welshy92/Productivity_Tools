extends Node2D

var current_sum: String = ""
var display_sum: String = ""
var error_symbols: Array = ["+", "-", "/", "*"]
var minus_count: int = 0



func updateSum() -> void:
	%CalcDisplay.text = display_sum
	print(current_sum)


func resetCalc() -> void:
	current_sum = ""
	display_sum = ""
	$CalcButtons/ButtonPlus.disabled = true
	$CalcButtons/ButtonMultiply.disabled = true
	$CalcButtons/ButtonDivide.disabled = true
	$CalcButtons/ButtonEquals.disabled = true


func disableOperands(operand: String) -> void:
	if not operand == "-" and not operand == ".":
		$CalcButtons/ButtonPlus.disabled = true
		$CalcButtons/ButtonMultiply.disabled = true
		$CalcButtons/ButtonDivide.disabled = true
		$CalcButtons/ButtonEquals.disabled = true
		$CalcButtons/ButtonMinus.disabled = false
		$CalcButtons/ButtonDecimal.disabled = false
		minus_count += 1
	elif operand == "-":
		minus_count += 1
		$CalcButtons/ButtonDecimal.disabled = false
		$CalcButtons/ButtonPlus.disabled = true
		$CalcButtons/ButtonMultiply.disabled = true
		$CalcButtons/ButtonDivide.disabled = true
		$CalcButtons/ButtonEquals.disabled = true
	elif operand == ".":
		$CalcButtons/ButtonDecimal.disabled = true
	
	if minus_count == 2:
		$CalcButtons/ButtonMinus.disabled = true


func enableOperands() -> void:
	$CalcButtons/ButtonPlus.disabled = false
	$CalcButtons/ButtonMinus.disabled = false
	$CalcButtons/ButtonMultiply.disabled = false
	$CalcButtons/ButtonDivide.disabled = false
	$CalcButtons/ButtonEquals.disabled = false



func _on_button_1_pressed() -> void:
	display_sum = str(display_sum + "1")
	current_sum = str(current_sum + "1")
	updateSum()
	enableOperands()


func _on_button_2_pressed() -> void:
	display_sum = str(display_sum + "2")
	current_sum = str(current_sum + "2")
	updateSum()
	enableOperands()


func _on_button_3_pressed() -> void:
	display_sum = str(display_sum + "3")
	current_sum = str(current_sum + "3")
	updateSum()
	enableOperands()


func _on_button_4_pressed() -> void:
	display_sum = str(display_sum + "4")
	current_sum = str(current_sum + "4")
	updateSum()
	enableOperands()


func _on_button_5_pressed() -> void:
	display_sum = str(display_sum + "5")
	current_sum = str(current_sum + "5")
	updateSum()
	enableOperands()


func _on_button_6_pressed() -> void:
	display_sum = str(display_sum + "6")
	current_sum = str(current_sum + "6")
	updateSum()
	enableOperands()


func _on_button_7_pressed() -> void:
	display_sum = str(display_sum + "7")
	current_sum = str(current_sum + "7")
	updateSum()
	enableOperands()


func _on_button_8_pressed() -> void:
	display_sum = str(display_sum + "8")
	current_sum = str(current_sum + "8")
	updateSum()
	enableOperands()


func _on_button_9_pressed() -> void:
	display_sum = str(display_sum + "9")
	current_sum = str(current_sum + "9")
	updateSum()
	enableOperands()


func _on_button_0_pressed() -> void:
	display_sum = str(display_sum + "0")
	current_sum = str(current_sum + "0")
	updateSum()
	enableOperands()


func _on_button_plus_pressed() -> void:
	display_sum = str(display_sum + "+")
	current_sum = str(current_sum + "+")
	disableOperands("+")
	updateSum()


func _on_button_minus_pressed() -> void:
	display_sum = str(display_sum + "-")
	current_sum = str(current_sum + "-")
	disableOperands("-")
	updateSum()


func _on_button_multiply_pressed() -> void:
	display_sum = str(display_sum + "x")
	current_sum = str(current_sum + "*")
	disableOperands("*")
	updateSum()


func _on_button_divide_pressed() -> void:
	display_sum = str(display_sum + "÷")
	current_sum = str(current_sum + "/")
	disableOperands("/")
	updateSum()


func _on_button_decimal_pressed() -> void:
	display_sum = str(display_sum + ".")
	current_sum = str(current_sum + ".")
	disableOperands(".")
	updateSum()


func _on_button_clear_pressed() -> void:
	display_sum = ""
	current_sum = ""
	updateSum()


func _on_button_equals_pressed() -> void:
	
	var parse_sum: String = current_sum
	if len(current_sum) <= 1:
		push_error("Invalid sum '", current_sum, "'. Length too short!")
		current_sum = "0"
		display_sum = "ERROR"
	
	elif current_sum[0] in error_symbols or current_sum[len(current_sum) - 1] in error_symbols:
		if current_sum[0] == "-":
			return
		else:
			push_error("Invalid sum '", current_sum, "'. Operand position error.")
			current_sum = "0"
			display_sum = "ERROR"


	if current_sum.contains("/") and not current_sum.contains("."):
		parse_sum = str(current_sum + ".0")
	else:
		parse_sum = current_sum

	var expression: Expression = Expression.new()
	expression.parse(parse_sum)
	var result: float = expression.execute()
	
	current_sum = str(result)
	
	if not display_sum == "ERROR":
		display_sum = String.num(result, 4)
	
	updateSum()
	resetCalc()
