extends Control
var sell_timer = 0.0
var sell_interval = 1.0

@onready var money_label = $VBoxContainer/Money
@onready var tomato_label = $VBoxContainer/Tomatoes
@onready var sauce_inv_label = $VBoxContainer/SauceInventory
@onready var lifetime_sauce_label = $VBoxContainer/LifetimeSauce
@onready var price_label = $VBoxContainer/Price
@onready var demand_label = $VBoxContainer/Demand

func _ready():
	update_ui()
	Global.load_data()
	$Passive.start(Global.machine_cooldown)


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



func _on_price_inc_pressed() -> void:
	Global.sauce_price += 0.01
	recalc_demand()
	update_ui()
	Global.save_data()

func sell_sauce():
	if Global.sauce_inventory <= 0:
		return
	for i in range(Global.sauce_inventory):
		var sell_chance = Global.public_demand * 0.1
		if randf() < sell_chance:
			Global.sauce_inventory -= 1
			Global.money += Global.sauce_price
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
