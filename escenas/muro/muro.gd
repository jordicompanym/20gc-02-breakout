extends Node2D

signal ladrillo_tocado
signal ladrillo_roto
signal muro_roto
signal partida_ganada

class Nivel:
	var tipos: Array[String]
	var n_columnas: int = 11
	var extras: Dictionary = {}  # Vector2i(fila, col) → String

var _nivel_actual: int = 0
var _ladrillos_restantes: int = 0
var _niveles: Array = []  # se rellena en _ready
var _ancho: float
var _alto: float

@export var ladrillo_scene: PackedScene
@export var _columnas: int = 11

const SAVE_PATH = "res://datos/niveles.json"

func _ready() -> void:
	_cargar_array_niveles()

func posicion_inicial(screen_size: Vector2, alto_marcador: float = 0.0) -> void:
	var area_juego_y := screen_size.y - alto_marcador
	_ancho = screen_size.x * 0.70
	_alto  = area_juego_y * 0.30
	position = Vector2(screen_size.x * 0.15, alto_marcador + area_juego_y * 0.15)
	$zona_deteccion/CollisionShape2D.shape.size = Vector2(_ancho, _alto)
	$zona_deteccion/CollisionShape2D.position   = Vector2(_ancho / 2.0, _alto / 2.0)
	#empezar_partida()

func empezar_partida() -> void:
	_nivel_actual = 0
	_generar_nivel(_niveles[_nivel_actual])

func _control_muro() -> void:
	_nivel_actual += 1
	if _nivel_actual < _niveles.size():
		await get_tree().create_timer(0.5).timeout
		_generar_nivel(_niveles[_nivel_actual])
	else: 
		# señal de partida ganada hacia arena/estado_juego
		partida_ganada.emit()

func _on_ladrillo_golpeado() -> void:
	ladrillo_tocado.emit()

func _on_ladrillo_destruido(global_position : Vector2, extra : String) -> void:
	_ladrillos_restantes -= 1
	ladrillo_roto.emit()
	$ladrillo_roto.play()
	if _ladrillos_restantes == 0:
		# todo: aumentar puntuacion por muro roto
		muro_roto.emit()
		$muro_roto.play()
		_control_muro()

func _cargar_array_niveles() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_as_text())
	var niveles := json.get_data() as Array
	
	for nivel_data in niveles:
		var n := Nivel.new()
		
		n.tipos.assign(nivel_data["tipos"])
		n.n_columnas = nivel_data["n_columnas"]
		for clave in nivel_data["extras"]:
			n.extras[str_to_var(clave)] = nivel_data["extras"][clave]
		_niveles.append(n)

func _generar_nivel(nivel: Nivel) -> void:
	_ladrillos_restantes = nivel.tipos.size() * nivel.n_columnas
	_columnas = nivel.n_columnas
	# asigna extra desde nivel.extras.get(Vector2i(fila, col), "")
	var ancho_ladrillo := _ancho / _columnas
	# _alto / nivel.tipos.size()
	# de momento fijo el alto para que en los niveles mas bajos con pocos tipos hay mas espacio entre 
	# el primer ladrillo y la bola
	var alto_ladrillo := 30 
	# print_debug("alto_ladrillo: ", alto_ladrillo, " ancho_ladrillo: ", ancho_ladrillo)
	var dimensiones := Vector2(ancho_ladrillo, alto_ladrillo)

	for fila in nivel.tipos.size():
		var tipo: TipoLadrillo = load("res://escenas/muro/assets/" + nivel.tipos[fila] + ".tres")
		for col in _columnas:
			var ladrillo = ladrillo_scene.instantiate()
			ladrillo.position = Vector2(col * ancho_ladrillo, fila * alto_ladrillo)
			add_child(ladrillo)
			ladrillo.configurar(tipo, dimensiones)
			ladrillo.ladrillo_destruido.connect(_on_ladrillo_destruido)
			ladrillo.ladrillo_golpeado.connect(_on_ladrillo_golpeado)
