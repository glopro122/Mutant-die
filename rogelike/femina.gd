extends CharacterBody2D
class_name player

@export var speed = 100
@export var fuerza_empuje = 800
@onready var sprite = $Sprite2D # Asegúrate de asignar el nodo Sprite2D en el editor

func animacion():
	if velocity:
		sprite.play("correr")
	else:
		sprite.play("Reposo")
func _ready() -> void:
	add_to_group("jugador")
	set_collision_mask_value(2, false)
	
	var area = Area2D.new()
	var col_shape = CollisionShape2D.new()
	col_shape.shape = CircleShape2D.new()
	col_shape.shape.radius = 20
	area.collision_mask = 2
	area.add_child(col_shape)
	add_child(area)
	area.area_entered.connect(_on_enemigo_detectado)

func _physics_process(delta: float) -> void:
	animacion()
	var direccion = Input.get_vector("izqui", "derecha", "arriba", "abajo")
	velocity = speed * direccion
	
	# Voltear sprite según dirección horizontal
	if direccion.x != 0:
		sprite.flip_h = direccion.x < 0  # True si va a la izquierda
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider.is_in_group("enemigos") and collider.has_method("recibir_empuje"):
			var direccion_empuje = velocity.normalized() * fuerza_empuje * delta
			collider.recibir_empuje(direccion_empuje)

func _on_enemigo_detectado(area: Area2D):
	pass
