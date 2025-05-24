extends CharacterBody2D
class_name player2

# Movimiento
@export var speed = 100
@export var fuerza_empuje = 800

# Atributos
var vida = 100
var daño = 10
var experiencia = 0
var nivel = 1

# Nodos
@onready var sprite = $Mago
var sistema_niveles: SistemaNivelesCirculares



func _ready():
	add_to_group("jugador")
	var area = Area2D.new()
	var col_shape = CollisionShape2D.new()
	col_shape.shape = CircleShape2D.new()
	col_shape.shape.radius = 20
	area.collision_mask = 2
	area.add_child(col_shape)
	add_child(area)

func _physics_process(delta):

	
	var direccion = Input.get_vector("izqui", "derecha", "arriba", "abajo")
	velocity = speed * direccion
	animacion()
	if direccion.x != 0:
		sprite.flip_h = direccion.x < 0
	
	move_and_slide()
	
	# Empuje a enemigos (tu código original)
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider.is_in_group("enemigos") and collider.has_method("recibir_empuje"):
			var direccion_empuje = velocity.normalized() * fuerza_empuje * delta
			collider.recibir_empuje(direccion_empuje)

func animacion():
	if velocity:
		sprite.play("Caminar")
	else:
		sprite.play("Reposo")

func ganar_experiencia(cantidad: int):
	if sistema_niveles:  # Verifica que la referencia exista
		sistema_niveles.ganar_experiencia(cantidad, self)
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if "is_enemy" in body:
		$Salud.recibir_daño(25)
	if "is_item" in body:
		print("Objeto recolectado", body.name)
		body.queue_free()
