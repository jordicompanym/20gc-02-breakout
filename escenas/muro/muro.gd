extends Node2D

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

func _ready() -> void:
	_cargar_array_niveles()

func posicion_inicial(screen_size: Vector2, alto_marcador: float = 0.0) -> void:
	var area_juego_y := screen_size.y - alto_marcador

	_ancho = screen_size.x * 0.70
	_alto  = area_juego_y * 0.30

	position = Vector2(screen_size.x * 0.15, alto_marcador + area_juego_y * 0.15)

	$zona_deteccion/CollisionShape2D.shape.size = Vector2(_ancho, _alto)
	$zona_deteccion/CollisionShape2D.position   = Vector2(_ancho / 2.0, _alto / 2.0)

	empezar_partida()

func empezar_partida() -> void:
	_nivel_actual = 0
	_generar_nivel(_niveles[_nivel_actual])

func _control_muro() -> void:
	_nivel_actual += 1
	if _nivel_actual < _niveles.size():
		await get_tree().create_timer(0.2).timeout
		_generar_nivel(_niveles[_nivel_actual])
	else: # señal de partida ganada hacia arena/estado_juego
		EstadoJuego.partida_ganada()

func _generar_nivel(nivel: Nivel) -> void:
	_ladrillos_restantes = nivel.tipos.size() * nivel.n_columnas
	_columnas = nivel.n_columnas
	# asigna extra desde nivel.extras.get(Vector2i(fila, col), "")
	var ancho_ladrillo := _ancho / _columnas
	# _alto / nivel.tipos.size()
	# de momento fijo el alto para que en los niveles mas bajos con pocos tipos hay mas espacio entre 
	# el primer ladrillo y la bola
	var alto_ladrillo := 30 
	print_debug("alto_ladrillo: ", alto_ladrillo, " ancho_ladrillo: ", ancho_ladrillo)
	var dimensiones := Vector2(ancho_ladrillo, alto_ladrillo)

	for fila in nivel.tipos.size():
		var tipo: TipoLadrillo = load("res://escenas/muro/assets/" + nivel.tipos[fila] + ".tres")
		for col in _columnas:
			var ladrillo = ladrillo_scene.instantiate()
			ladrillo.position = Vector2(col * ancho_ladrillo, fila * alto_ladrillo)
			add_child(ladrillo)
			ladrillo.configurar(tipo, dimensiones)
			ladrillo.destruido.connect(_on_ladrillo_destruido)

func _on_ladrillo_destruido(global_position : Vector2, extra : String) -> void:
	_ladrillos_restantes -= 1
	if _ladrillos_restantes == 0:
		_control_muro()

func _cargar_array_niveles() -> void:
	var n1 := Nivel.new()
	n1.tipos = ["tipo_amarillo", "tipo_azul", "tipo_azul_flojo"]
	n1.n_columnas = 6
	n1.extras = {
		Vector2i(0, 1): "bola_explota",
		Vector2i(1, 3): "pala_grande",
		Vector2i(2, 5): "pistola",
	}
	_niveles.append(n1)
	var n2 := Nivel.new()
	n2.tipos = ["tipo_amarillo", "tipo_azul", "tipo_azul_flojo", "tipo_gris"]
	n2.n_columnas = 6
	n2.extras = {
		Vector2i(0, 1): "bola_explota",
		Vector2i(1, 3): "pala_grande",
		Vector2i(2, 5): "pistola",
	}
	_niveles.append(n2)
