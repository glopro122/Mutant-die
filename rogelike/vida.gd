class_name BarraSalud extends ProgressBar

var valor_target := 0.0

func _process(delta):
	if valor_target > 0.0:
		var aux
		aux = move_toward(self.value, valor_target, delta * 5.0)
		self.value = aux

func actualizar_barra(maximo: float, actual: float):
	valor_target = actual / maximo
