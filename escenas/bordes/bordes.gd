extends Node2D

func posicion_inicial(screen_size : Vector2, alto_marcador : float) -> void:
	var alto_juego := screen_size.y - alto_marcador
	# posicionando los limites
	$limite_superior.shape.size = Vector2(screen_size.x, 5)
	$limite_superior.position = Vector2(screen_size.x / 2, alto_marcador + 5)
	
	$limite_izquierdo.shape.size = Vector2(15, alto_juego)
	$limite_izquierdo.position = Vector2(0, alto_marcador + alto_juego / 2)
	
	$limite_derecho.shape.size = Vector2(15, alto_juego)
	$limite_derecho.position = Vector2(screen_size.x, alto_marcador + alto_juego / 2)
	
	# posicionando la zona de muerte
	$zona_muerte/limite_inferior.shape.size = Vector2(screen_size.x, 5)
	$zona_muerte/limite_inferior.position = Vector2(screen_size.x / 2, screen_size.y - 4)
