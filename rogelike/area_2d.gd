extends Area2D

@onready var enemigo = preload("res://guerrero.tscn")
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
		var enemi_instance = enemigo.instantiate()
		enemi_instance.position = Vector2(random.randi_range(10,1200),random.randi_range(10,150))
		get_parent().add_child(enemi_instance)

func _on_timer_timeout() -> void:
	bool_spawn = true
