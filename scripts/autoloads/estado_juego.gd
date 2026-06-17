extends Node

var puntuacion : int = 0
var vidas : int = 5

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

func continuar_partida() -> void:
	get_tree().change_scene_to_file("res://escenas/arena/arena.tscn")

func abrir_opciones() -> void:
	Configuracion._copiar_cfg(Configuracion.cfg_actual, Configuracion.cfg_nueva)
	get_tree().change_scene_to_file("res://escenas/pantallas/pantalla_opciones.tscn")

func aumentar_puntuacion(puntos : int) -> void:
	puntuacion += puntos

func perder_vida() -> void:
	vidas -= 1
	if vidas <= 0:
		get_tree().change_scene_to_file("res://escenas/pantallas/gameover.tscn")

func salir() -> void:
	get_tree().quit()
