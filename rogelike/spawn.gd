extends Area2D


@onready var jugador = load(Global.personajes_disponibles[Global.personaje_seleccionado]["ruta"])
var bool_spawn = true

var random = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn()
	
	
func spawn():
	if bool_spawn:
		$Timer.start()
		bool_spawn = false
		var enemi_instance = jugador.instantiate()
		enemi_instance.position = Vector2(0,0)
		get_parent().add_child(enemi_instance)

func _on_timer_timeout() -> void:
	bool_spawn = true
