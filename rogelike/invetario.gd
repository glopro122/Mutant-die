extends CanvasLayer

# Exporta los sprites desde el inspector
@export var slot_sprites: Array[Sprite2D] = []
var items: Array = [null, null, null, null]  # 4 slots
var selected_slot: int = -1

func _ready():
	hide_inventory()
	update_slots_visuals()

func add_item(item_texture: Texture2D) -> bool:
	# Buscar primer slot vacío
	for i in range(items.size()):
		if items[i] == null:
			items[i] = {
				"texture": item_texture,
				"quantity": 1
			}
			update_slots_visuals()
			return true
	return false  # Inventario lleno

func remove_item(slot_index: int) -> void:
	if slot_index >= 0 and slot_index < items.size():
		items[slot_index] = null
		update_slots_visuals()

func update_slots_visuals():
	for i in range(slot_sprites.size()):
		if i < items.size() and items[i] != null:
			slot_sprites[i].texture = items[i]["texture"]
			slot_sprites[i].visible = true
		else:
			slot_sprites[i].visible = false

func show_inventory():
	self.visible = true
	update_slots_visuals()

func hide_inventory():
	self.visible = false

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if visible:
			hide_inventory()
		else:
			show_inventory()
	
	# Selección con teclas numéricas
	if visible:
		for i in range(4):
			if event.is_action_pressed("slot_%d" % (i+1)):
				select_slot(i)

func select_slot(slot_index: int):
	selected_slot = slot_index
	# Aquí puedes añadir efectos visuales de selección
	print("Slot seleccionado:", slot_index + 1)
