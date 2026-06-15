extends Node

var puntuacion : int = 0
var vidas : int = 5

const RUTA_CONFIG := "user://configuracion.cfg"
var configuracion := ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Aqui deberian ir las cargas de configuraciones.
	var error := configuracion.load(RUTA_CONFIG) # si no existe, simplemente no carga nada
	if error:
		_generar_configuracion_defecto()
	else:
		_cargar_idioma()

## Funcion para cargar el idioma de la configuracion
func _cargar_idioma() -> void:
	var idioma : String = configuracion.get_value("ajustes", "idioma", "es")	
	TranslationServer.set_locale(idioma)

## Funcion para generar la configuracion por defecto	
func _generar_configuracion_defecto():
	configuracion.load("res://configuraciones/configuracion.cfg")
	configuracion.save(RUTA_CONFIG)
	_cargar_idioma()

##################################################
## Funciones para la gestión principal del juego #
##################################################

func nueva_partida() -> void:
	puntuacion = 0
	vidas = 5
	get_tree().change_scene_to_file("res://escenas/arena/arena.tscn")

func continuar_partida() -> void:
	get_tree().change_scene_to_file("res://escenas/arena/arena.tscn")

func abrir_opciones() -> void:
	get_tree().change_scene_to_file("res://escenas/pantallas/pantalla_opciones.tscn")

func aumentar_puntuacion(puntos : int) -> void:
	puntuacion += puntos

func perder_vida() -> void:
	vidas -= 1
	if vidas <= 0:
		get_tree().change_scene_to_file("res://escenas/pantallas/gameover.tscn")

func salir() -> void:
	get_tree().quit()
