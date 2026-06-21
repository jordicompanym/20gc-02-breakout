extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size := get_viewport_rect().size
	_posicionamiento_inicial.call_deferred(screen_size)
	
	$pala.paleta_movimiento_inicial.connect($pelota.saque.bind(screen_size))
	$pantalla_pausa.visible = false
	$pantalla_opciones.visible = false
	
func _posicionamiento_inicial(screen_size : Vector2) -> void:
	# posicionamiento de los nodos en pantalla
	$ColorRect.size = screen_size
	$marcador.posicion_inicial(screen_size)
	$bordes.posicion_inicial(screen_size, $marcador/Control.size.y)
	$pala.posicion_inicial(screen_size)
	$pelota.posicion_inicial($pala.position, $pala/ColorRect.size)
	$pantalla_pausa.position = Vector2(screen_size.x/2, screen_size.y/2)
	$pantalla_opciones.position = Vector2(screen_size.x/2, screen_size.y/2)

func muerte() ->void:
	print_debug("muerte")
	var _screen_size := get_viewport_rect().size
	EstadoJuego.perder_vida()
	#reiniciar pala y pelota
	$pala.posicion_inicial(_screen_size)
	$pelota.posicion_inicial($pala.position, $pala/ColorRect.size)
