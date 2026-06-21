extends Node

var puntuacion : int = 0
var vidas : int = 5
var bufos : String = "Ninguno"
var debufos : String = "Ninguno"
var quien_llama_opciones : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

###########################################################
## Funciones públicas para la gestión principal del juego #
###########################################################
func nueva_partida() -> void:
	### reiniciar puntuacion y vidas
	puntuacion = 0
	vidas = 5
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

# gestion del marcador
func aumentar_puntuacion(puntos : int) -> void:
	puntuacion += puntos

func perder_vida() -> void:
	vidas -= 1
	if vidas <= 0:
		get_tree().change_scene_to_file("res://escenas/pantallas/gameover.tscn")
