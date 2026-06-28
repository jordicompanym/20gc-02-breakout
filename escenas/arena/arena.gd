extends Node2D

var _screen_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_screen_size = get_viewport_rect().size

	$pantalla_pausa.visible = false
	$pantalla_opciones.visible = false
	_posicionamiento_inicial.call_deferred()
	# conectores
	$pala.paleta_movimiento_inicial.connect($pelota.saque.bind(_screen_size))
	$bordes/zona_muerte.body_entered.connect(_muerte.bind())
	
func _posicionamiento_inicial() -> void:
	# posicionamiento de los nodos en pantalla
	$ColorRect.size = _screen_size
	$marcador.posicion_inicial(_screen_size)
	$bordes.posicion_inicial(_screen_size, $marcador/Control.size.y)
	$muro.posicion_inicial(_screen_size, $marcador/Control.size.y)	
	$pala.posicion_inicial()
	$pelota.posicion_inicial($pala.position, $pala/ColorRect.size)
	$pantalla_pausa.position = Vector2(_screen_size.x/2, _screen_size.y/2)
	$pantalla_opciones.position = Vector2(_screen_size.x/2, _screen_size.y/2)

func _muerte(_body: Node) -> void:
	EstadoJuego.perder_vida()
