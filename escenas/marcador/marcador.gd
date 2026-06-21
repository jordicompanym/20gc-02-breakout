extends CanvasLayer

func posicion_inicial(screen_size : Vector2) -> void:
	var ancho : float = $Control.size.x / 4
	# marcador ocupa todo la zona superior
	$Control.size.x = screen_size.x
	$Control.size.y = 30
	# tamaño del marcador de vidas
	$Control/etiqueta_vidas.size.x = ancho
	$Control/etiqueta_vidas.position.x = 0
	# tamaño del marcador de bufos
	$Control/etiqueta_bufos.size.x = ancho
	$Control/etiqueta_bufos.position.x = ancho
	# tamaño del marcador de bufos
	$Control/etiqueta_debufos.size.x = ancho
	$Control/etiqueta_debufos.position.x = ancho * 2
	# tamaño del marcador de puntos
	$Control/etiqueta_puntos.size.x = ancho
	$Control/etiqueta_puntos.position.x = ancho * 3
	# actualizar todos los marcadores
	actualizar_marcador()

func actualizar_marcador() -> void:
	$Control/etiqueta_vidas.text = str(EstadoJuego.vidas)
	$Control/etiqueta_bufos.text = str(EstadoJuego.bufos)
	$Control/etiqueta_debufos.text = str(EstadoJuego.debufos)
	$Control/etiqueta_puntos.text = str(EstadoJuego.puntuacion)
	
