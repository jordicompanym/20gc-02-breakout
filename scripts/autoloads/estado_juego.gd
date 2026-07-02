extends Node

signal cambio_estado(nuevo: Estado)
signal actualizada_puntuacion()
enum Estado { ACTIVO, PARADO, FINJUEGO }  # fácil de extender a GAME_OVER, etc.

var puntuacion : int = 0
var vidas : int = 5
var bufos : String = ""
var debufos : String = ""
var quien_llama_opciones : String
var estado : Estado = Estado.PARADO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

###########################################################
## Funciones públicas para la gestión principal del juego #
###########################################################
func cambiar_estado(nuevo_estado : Estado) -> void:
	estado = nuevo_estado
	emit_signal("cambio_estado", estado)

func nueva_partida() -> void:
	### reiniciar puntuacion y vidas
	reiniciar_marcador()
	## cambiar a la escena de juego
	get_tree().change_scene_to_file("res://escenas/arena/arena.tscn")

func salir() -> void:
	get_tree().quit()
	
# gestionar pantalla de opciones
func _pausar_reanudar_partida() -> void:
	get_tree().paused = !get_tree().paused

# gestionar pantalla de opciones
func abrir_opciones(quien_llama : String) -> void:
	Configuracion._copiar_cfg(Configuracion.cfg_actual, Configuracion.cfg_nueva)
	quien_llama_opciones = quien_llama
	if quien_llama_opciones == "pantalla_inicial":
		get_tree().change_scene_to_file("res://escenas/pantallas/pantalla_opciones.tscn")

func cerrar_opciones() -> void:
	if quien_llama_opciones == "pantalla_inicial":
		get_tree().change_scene_to_file("res://escenas/pantallas/pantalla_inicial.tscn")

###########################################################
## Funciones de gestión del marcador                      #
###########################################################
func reiniciar_marcador() -> void:
	puntuacion = 0
	vidas = 5
	bufos = ""
	debufos = ""
	
func aumentar_puntuacion(puntos : int) -> void:
	puntuacion += puntos
	emit_signal("actualizada_puntuacion")

func perder_vida() -> void:
	vidas -= 1
	cambiar_estado(EstadoJuego.Estado.PARADO)
	if vidas < 1:
		cambiar_estado(EstadoJuego.Estado.FINJUEGO)
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://escenas/pantallas/pantalla_inicial.tscn")
		
func partida_ganada() -> void:
	cambiar_estado(EstadoJuego.Estado.FINJUEGO)
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://escenas/pantallas/pantalla_inicial.tscn")
