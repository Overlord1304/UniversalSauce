extends Control
var sell_timer = 0.0
var sell_interval = 1.0

@onready var money_label = $VBoxContainer/Money
@onready var tomato_label = $VBoxContainer/Tomatoes
@onready var sauce_inv_label = $VBoxContainer/SauceInventory
@onready var lifetime_sauce_label = $VBoxContainer/LifetimeSauce
@onready var price_label = $VBoxContainer/Price
@onready var demand_label = $VBoxContainer/Demand
@onready var pepper_label = $PepperPanel/Pepper
@onready var revenue_label = $Revenue
@onready var spice_label = $PepperPanel/Spice
func _ready():
	update_ui()
	Global.load_data()
	$Passive.start(Global.machine_cooldown)
	$Pepper.start()
	if Global.plug1bought:
		$PepperPanel/ScrollContainer/VBoxContainer/plug1.queue_free()
	if Global.plug2bought:
		$PepperPanel/ScrollContainer/VBoxContainer/plug2.queue_free()
	if Global.plug3bought:
		$PepperPanel/ScrollContainer/VBoxContainer/plug3.queue_free()

func _process(delta):
	Global.marketing_boost = Global.marketing_lvl * 0.25
	sell_timer += delta
	if sell_timer >= sell_interval:
		sell_timer = 0
		sell_sauce()
	update_ui()
func update_ui():
	money_label.text = "Money: $"+Global.format_number(Global.money)
	tomato_label.text = "Tomatoes: "+Global.format_number(Global.tomatoes)
	sauce_inv_label.text= "Sauce Bottles: "+Global.format_number(Global.sauce_inventory)
	lifetime_sauce_label.text = "Lifetime Sauce Ever Made: "+Global.format_number(Global.lifetime_sauce)
	price_label.text = "Price Per Bottle: $"+Global.format_number(Global.sauce_price)
	demand_label.text = "Public Demand: " +Global.format_number(int(Global.public_demand*(1+Global.marketing_boost)*100))+"%"
	pepper_label.text = "Pepper: "+ str(round(Global.pepper))+" / "+ str(Global.pepper_cap)
	spice_label.text = "Spice: "+str(round(Global.spice))
	if Global.revenue_enabled:
		revenue_label.visible = true
		revenue_label.text = "Revenue/sec: $" + Global.format_number(Global.revenue_per_sec)
	else:
		revenue_label.visible = false
func make_sauce(check):
	if Global.tomatoes >= 1:
		if check == 0:
			Global.tomatoes -= 1
			Global.sauce_inventory += Global.sauce_per_click
			Global.lifetime_sauce += Global.sauce_per_click
			update_ui()
			Global.save_data()
		else:
			Global.tomatoes -= Global.sauce_per_second
			Global.sauce_inventory += Global.sauce_per_second
			Global.lifetime_sauce += Global.sauce_per_second
			update_ui()
			Global.save_data()
func _on_make_sauce_pressed() -> void:
	make_sauce(0)


func generate_pepper():
	Global.pepper += Global.pepper_per_sec
	Global.pepper = min(Global.pepper,Global.pepper_cap)
	if Global.pepper >= Global.pepper_cap:
		Global.spice += 1
func _on_price_inc_pressed() -> void:
	Global.sauce_price += 0.01
	recalc_demand()
	update_ui()
	Global.save_data()

func sell_sauce():
	if Global.sauce_inventory <= 0:
		Global.revenue_per_sec = 0
		return
	var earnings = 0.0
	for i in range(Global.sauce_inventory):
		var sell_chance = Global.public_demand * 0.1
		if randf() < sell_chance:
			Global.sauce_inventory -= 1
			Global.money += Global.sauce_price
			earnings += Global.sauce_price
	Global.revenue_per_sec = earnings
	Global.save_data()
func _on_price_dec_pressed() -> void:
	if Global.sauce_price > 0.01:
		Global.sauce_price -= 0.01 
		recalc_demand()
		update_ui()
		Global.save_data()
func recalc_demand(): 
	Global.public_demand = 0.08 / max(Global.sauce_price,0.01)
func _on_buy_tomato_pressed() -> void:
	if Global.money >= Global.tomato_price:
		Global.money -= Global.tomato_price
		Global.tomatoes += 1000*(1+Global.tomato_boost)
		update_ui()
		Global.save_data()

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")


func _on_passive_timeout() -> void:
	make_sauce(1)
	


func _on_pepper_timeout() -> void:
	generate_pepper()

func fade_out(button):
	button.disabled = true
	var tween := get_tree().create_tween()
	tween.tween_property(button, "modulate:a", 0.0, 0.4)
	tween.finished.connect(button.queue_free)


func _on_plug_1_pressed() -> void:
	if Global.pepper >= 500:
		Global.pepper -= 500
		Global.plug1bought = false
		Global.revenue_enabled = true
		fade_out($PepperPanel/ScrollContainer/VBoxContainer/plug1)
		update_ui()
		Global.save_data()


func _on_plug_2_pressed() -> void:
	if Global.pepper >= 750:
		Global.pepper -= 750
		Global.plug2bought = false
		Global.pepper_cap = 2500
		fade_out($PepperPanel/ScrollContainer/VBoxContainer/plug2)
		update_ui()
		Global.save_data()

func _on_plug_3_pressed() -> void:
	if Global.pepper >= 1500:
		Global.pepper -= 1500
		Global.plug3bought = false
		Global.pepper_per_sec = 8
		fade_out($PepperPanel/ScrollContainer/VBoxContainer/plug3)
		update_ui()
		Global.save_data()


func _on_plug_4_pressed() -> void:
	if Global.spice >= 25 and Global.pepper >= 2500:
		Global.pepper -= 1500
		Global.spice -= 25
		Global.plug4bought = false
		Global.marketing_boost *= 1.5
		fade_out($PepperPanel/ScrollContainer/VBoxContainer/plug4)
		update_ui()
		Global.save_data()
