extends Node
var money = 0.0
var tomatoes = 1000
var sauce_inventory = 0
var lifetime_sauce = 0
var sauce_price = 0.25
var public_demand = 1.0
var tomato_price = 20
var sell_timer = 0.0
var sell_interval = 1.0
var sauce_per_click = 1
var sauce_per_second = 0
var marketing_lvl = 0
var marketing_boost = 0
var tomato_boost = 0
var machine_cooldown = 1.0
var upg1cost = 6.00
var upg2cost = 100.00
var upg3cost = 250.00
var upg3bought = false
var upg4cost = 250.00
var upg4bought = false
var upg5cost = 850.00
var upg5bought = false
var upg6cost = 600.00
var upg6bought = false
var saves = "user://userdata.save"
func save_data():
	var data = {
		"money": money,
		"tomatoes": tomatoes,
		"sauce_inventory": sauce_inventory,
		"lifetime_sauce": lifetime_sauce,
		"sauce_price": sauce_price,
		"public_demand": public_demand,
		"tomato_price": tomato_price,
		"sauce_per_click": sauce_per_click,
		"sauce_per_second": sauce_per_second,
		"upg1cost": upg1cost,
		"upg2cost": upg2cost,
		"upg3cost": upg3cost,
		"upg3bought": upg3bought,
		"upg4cost": upg4cost,
		"upg4bought": upg4bought,
		"upg5cost": upg5cost,
		"upg5bought": upg5bought,
		"upg6cost": upg6cost,
		"upg6bought": upg6bought,
		"marketing_lvl": marketing_lvl,
		"marketing_boost": marketing_boost,
		"tomato_boost": tomato_boost,
		"machine_cooldown": machine_cooldown
	}
	var file = FileAccess.open(saves,FileAccess.WRITE)
	file.store_var(data)
	file.close()
func load_data():
	if FileAccess.file_exists(saves):
		var file = FileAccess.open(saves,FileAccess.READ)
		var data = file.get_var()
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			money = data.get("money",0.0)
			tomatoes = data.get("tomatoes",0.0)
			sauce_inventory = data.get("sauce_inventory",0.0)
			lifetime_sauce = data.get("lifetime_sauce",0.0)
			sauce_price = data.get("sauce_price",0.25)
			public_demand = data.get("public_demand",1.0)
			tomato_price = data.get("tomato_price",20.0)
			sauce_per_click = data.get("sauce_per_click",1)
			sauce_per_second = data.get("sauce_per_click",0)
			upg1cost = data.get("upg1cost",6.00)
			upg2cost = data.get("upg2cost",100.00)
			upg3cost = data.get("upg3cost",250.00)
			upg3bought = data.get("upg3bought",false)
			upg4cost = data.get("upg4cost",250.00)
			upg4bought = data.get("upg4bought",false)
			upg5cost = data.get("upg5cost",850.00)
			upg5bought = data.get("upg5bought",false)
			upg5cost = data.get("upg5cost",600.00)
			upg5bought = data.get("upg5bought",false)
			marketing_lvl = data.get("marketing_lvl",0)
			marketing_boost = data.get("marketing_boost",0)
			tomato_boost = data.get("tomato_boost",0)
			machine_cooldown = data.get("machine_cooldown",0)
	else:
		save_data()
func format_number(n):
	var suffs = ["","K","M","B","T"]
	var index = 0
	while n >= 1000.0 and index < suffs.size() - 1:
		n /= 1000.0
		index+= 1
	n = snapped(n,0.01)
	var text = str(n)
	if "." in text:
		text = text.rstrip("0").rstrip(".")
	return text + suffs[index]
