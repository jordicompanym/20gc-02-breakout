extends CanvasLayer

func _ready() -> void:
	EstadoJuego.cambio_estado.connect(_on_cambio_estado)
	EstadoJuego.actualizada_puntuacion.connect(_on_actualizada_puntuacion)

func _on_cambio_estado(_nuevo_estado : EstadoJuego.Estado) -> void:
	_actualizar_marcador()

func _on_actualizada_puntuacion() -> void:
	_actualizar_marcador()

func posicion_inicial(screen_size : Vector2) -> void:
	var ancho : float = $control.size.x / 4
	# marcador ocupa todo la zona superior
	$control.size.x = screen_size.x
	$control.size.y = 30
	# tamaño del marcador de vidas
	$control/etiqueta_vidas.size.x = ancho
	$control/etiqueta_vidas.position.x = 0
	# tamaño del marcador de bufos
	$control/etiqueta_bufos.size.x = ancho
	$control/etiqueta_bufos.position.x = ancho
	# tamaño del marcador de bufos
	$control/etiqueta_debufos.size.x = ancho
	$control/etiqueta_debufos.position.x = ancho * 2
	# tamaño del marcador de puntos
	$control/etiqueta_puntos.size.x = ancho
	$control/etiqueta_puntos.position.x = ancho * 3
	# actualizar todos los marcadores
	_actualizar_marcador()

func actualizar_vidas(vida: int) -> void:
	for i in $control/etiqueta_vidas.get_child_count():
		if i + 1 == vida:
			var corazon = $control/etiqueta_vidas.get_child(i)
			corazon.modulate = Color(0.3, 0.3, 0.3)

func _actualizar_marcador() -> void:
	$control/etiqueta_bufos.text = str(EstadoJuego.bufos)
	$control/etiqueta_debufos.text = str(EstadoJuego.debufos)
	$control/etiqueta_puntos.text = str(EstadoJuego.puntuacion)
	
