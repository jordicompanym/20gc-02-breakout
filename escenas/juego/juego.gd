extends Node2D

enum Estados { ACTIVO, PERDIDAVIDA, PARADO, FINJUEGO } 
enum Ubicaciones {INICIAL, JUGANDO, OPCIONES}

signal estado_cambiado

var _screen_size : Vector2
var puntuacion : int = 0
var vidas : int = 5
var bufos : String = ""
var debufos : String = ""
var jugando : bool = false
var ubicacion : Ubicaciones = Ubicaciones.INICIAL
var estado : Estados = Estados.PARADO

const puntos_ladrillo = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$musica.play()
	_screen_size = get_viewport_rect().size
	_posicionamiento_inicial.call_deferred()
	_abrir_inicial()
	_rellenar_controles()
	# conectores
	$arena/pala.paleta_en_posicion_inicial.connect($arena/pelota.saque.bind(_screen_size))
	$arena/bordes/zona_muerte.body_entered.connect(_muerte.bind())
	$arena/muro.ladrillo_roto.connect(_ladrillo_roto.bind())
	$arena/muro.ladrillo_tocado.connect(_ladrillo_golpeado.bind())
	$arena/muro.muro_roto.connect(_muro_roto.bind())
	$arena/muro.partida_ganada.connect(_partida_ganada.bind())
	$arena/pelota.saque_realizado.connect(_on_saque_realizado.bind())
	
# GESTION DE JUEGO
func _pausar_juego() -> void:
	get_tree().paused = true
	_abrir_inicial()

func _nueva_partida() -> void:
	jugando = true
	ubicacion = Ubicaciones.JUGANDO
	_cambiar_estado(Estados.ACTIVO)
	get_tree().paused = false
	_reiniciar_marcador()
	$arena/muro.empezar_partida()
	_visible_arena(true) 
	$pantalla_inicial.visible = false
	$pantalla_opciones.visible = false

func _reanudar_partida() -> void:
	get_tree().paused = false
	ubicacion = Ubicaciones.JUGANDO
	_visible_arena(true) 
	$pantalla_inicial.visible = false
	$pantalla_opciones.visible = false

func _reiniciar_marcador() -> void:
	puntuacion = 0
	vidas = 5
	bufos = ""
	debufos = ""

func _aumentar_puntuacion(puntos : int) -> void:
	puntuacion += puntos
	$arena/marcador.actualizar_marcador()

func _perder_vida() -> void:
	_cambiar_estado(Estados.PERDIDAVIDA)
	$vida_perdida.play()
	vidas -= 1
	if vidas < 1:
		_partida_perdida()

func _partida_ganada() -> void:
	jugando = false
	_cambiar_estado(Estados.FINJUEGO)
	$partida_ganada.play()
	await get_tree().create_timer(0.5).timeout
	# falta lanzar musica y la pantalla de partida ganada
	_abrir_inicial()

func _partida_perdida() -> void:
	jugando = false
	_cambiar_estado(Estados.FINJUEGO)
	$partida_perdida.play()
	await get_tree().create_timer(0.5).timeout
	# falta lanzar  musica y la pantalla de fin de juego
	_abrir_inicial()


func _muerte(_body: Node) -> void:
	$arena/marcador.actualizar_vidas(vidas)
	_perder_vida()

func _cambiar_estado(nuevo_estado : Estados) -> void:
	estado = nuevo_estado
	emit_signal("estado_cambiado", estado)
	if estado == Estados.PARADO || estado == Estados.PERDIDAVIDA:
		$arena/pala.posicion_inicial()

func _on_saque_realizado() -> void:
	_cambiar_estado(Estados.ACTIVO)

func _posicionamiento_inicial() -> void:
	$arena/fondo.size = _screen_size
	$arena/marcador.posicion_inicial(_screen_size)
	$arena/bordes.posicion_inicial(_screen_size, $arena/marcador/control.size.y)
	$arena/muro.posicion_inicial(_screen_size, $arena/marcador/control.size.y)
	$arena/pala.posicion_inicial()
	$arena/pelota.posicion_inicial($arena/pala.position, $arena/pala.dimension_pala())
	$pantalla_inicial.size = Vector2(_screen_size.x , _screen_size.y)
	$pantalla_inicial.position = Vector2(0 ,0)
	$pantalla_opciones.size = Vector2(_screen_size.x , _screen_size.y)
	$pantalla_opciones.position = Vector2(0 ,0)


func _ladrillo_golpeado() -> void:
	_aumentar_puntuacion(puntos_ladrillo)
	
func _ladrillo_roto() -> void:
	_aumentar_puntuacion(puntos_ladrillo)
	
func _muro_roto() -> void:
	_aumentar_puntuacion(puntos_ladrillo * 2)

#GESTION DE APERTURA Y CIERRE DE PANTALLAS
func _visible_arena(valor : bool) ->void:
	$arena.visible = valor
	$arena/marcador.visible = valor

func _abrir_opciones() -> void:
	# parar el juego
	Configuracion._copiar_cfg(Configuracion.cfg_actual, Configuracion.cfg_nueva)
	ubicacion = Ubicaciones.OPCIONES
	get_tree().paused = true
	_visible_arena(false)
	$pantalla_inicial.visible = false
	$pantalla_opciones.visible = true

func _abrir_inicial() -> void:
	# parar el juego
	ubicacion = Ubicaciones.INICIAL
	get_tree().paused = true
	if jugando == false:
		$pantalla_inicial/CenterContainer/VBoxContainer/reanudar. visible = false
		$pantalla_inicial/CenterContainer/VBoxContainer/nueva. visible = true
	else:
		$pantalla_inicial/CenterContainer/VBoxContainer/reanudar. visible = true
		$pantalla_inicial/CenterContainer/VBoxContainer/nueva. visible = false

	_visible_arena(false)
	$pantalla_inicial.visible = true
	$pantalla_opciones.visible = false

func _salir() -> void:
	get_tree().quit()

# CONFIGURACION
func _rellenar_controles() -> void:
	var _idioma = Configuracion.cfg_actual.get_value("juego","idioma","es")
	var _dificultad = Configuracion.cfg_actual.get_value("juego","dificultad",2)
	var _vol_musica = Configuracion.cfg_actual.get_value("audio","volumen_musica",100)
	var _vol_sfx = Configuracion.cfg_actual.get_value("audio","volumen_sfx",100)
	var _pantalla_completa = Configuracion.cfg_actual.get_value("video","pantalla_completa",false)

	for idioma in Configuracion.lista_idiomas_disponibles():
		var literal := "IDIOMA_%s" % idioma["codigo"].to_upper()
		$pantalla_opciones/CenterContainer/VBoxContainer/HBoxContainer/select_idioma.add_item(literal, idioma["id"])
		if idioma["codigo"] == _idioma:			
			$pantalla_opciones/CenterContainer/VBoxContainer/HBoxContainer/select_idioma.select(idioma["id"])

	$pantalla_opciones/CenterContainer/VBoxContainer/HBoxContainer3/vol_musica.value = _vol_musica
	$pantalla_opciones/CenterContainer/VBoxContainer/HBoxContainer4/vol_sfx.value = _vol_sfx
	$pantalla_opciones/CenterContainer/VBoxContainer/HBoxContainer2/select_pantalla_completa.button_pressed = _pantalla_completa

func _cambiado_idioma(index : int) -> void:
	for idioma in Configuracion.lista_idiomas_disponibles():
		var id = idioma["id"]
		if id == index:
			Configuracion.actualizar_cfg("juego", "idioma", idioma["codigo"])

func _cambiada_vol_musica(nuevo : float) -> void:
	Configuracion.actualizar_cfg("audio", "volumen_musica", nuevo)

func _cambiada_vol_sfx(nuevo : float) -> void:
	Configuracion.actualizar_cfg("audio", "volumen_sfx", nuevo)

func _cambiada_pantalla_completa(nuevo : bool) -> void:
	Configuracion.actualizar_cfg("video", "pantalla_completa", nuevo)

func _guardar() -> void:
	Configuracion.guardar_nueva_cfg()
	_abrir_inicial()
