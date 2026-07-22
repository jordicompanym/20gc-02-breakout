extends Node

var cfg_actual := ConfigFile.new()
var cfg_nueva := ConfigFile.new()
var cfg_modificada : bool = false

const RUTA_CONFIG := "user://configuracion.cfg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## Aqui deberian ir las cargas de cfges.
	var error : Error = cfg_actual.load(RUTA_CONFIG) # si no existe, simplemente no carga nada
	if error:
		_generar_cfg_defecto()
	else:
		_cargar_nueva_cfg()

###########################################################
## Funciones públicas para la gestión de la configuración #
###########################################################

## Esta funcion devuelve un array de diccionarios con los idiomas disponibles, cada diccionario tiene el id, el codigo y el nombre del idioma
func lista_idiomas_disponibles() -> Array:
	var idiomas := TranslationServer.get_loaded_locales()
	var literales : Array
	var x := 0
	for idioma in idiomas:
		var item = {"id" : x, "codigo" : idioma, "nombre" : TranslationServer.get_locale_name(idioma)}
		literales.append(item)
		x += 1
	return literales

func idioma_cfg() -> String:
	return cfg_actual.get_value("juego","idioma","es")
	
func dificultad_cfg() -> String:
	return cfg_actual.get_value("juego","dificultad",2)

func volumen_musica_cfg() -> int:
	return cfg_actual.get_value("audio","volumen_musica",50)

func volumen_sfx_cfg() -> int:
	return cfg_actual.get_value("audio","volumen_sfx",50)
	
func pantalla_completa_cfg() -> bool:
	return cfg_actual.get_value("video","pantalla_completa",false)

func actualizar_cfg(seccion: String, clave: String, valor) -> void:
	cfg_nueva.set_value(seccion, clave, valor)
	cfg_modificada = true

func guardar_nueva_cfg() -> void:
	if cfg_modificada:
		cfg_nueva.save(RUTA_CONFIG)
		cfg_actual.load(RUTA_CONFIG)
		_cargar_nueva_cfg()

###########################################################
## Funciones privadas para la gestión de la configuración #
###########################################################

## Funcion para generar la cfg por defecto
func _generar_cfg_defecto() -> void:
	cfg_actual.load("res://configuraciones/configuracion.cfg")
	cfg_actual.save(RUTA_CONFIG)
	_cargar_nueva_cfg()

## Funcion para cargar el idioma de la cfg
func _cargar_nueva_cfg() -> void:
	## esto carga en el server tranlation el idioma que haya en la configuración, si no hay nada, carga el español por defecto
	TranslationServer.set_locale(cfg_actual.get_value("juego", "idioma", "es"))
	## volumen de musica
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(cfg_actual.get_value("audio","volumen_sfx","10")))
	## volumen de sfx
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"), linear_to_db(cfg_actual.get_value("audio","volumen_musica","10")))
	## pantalla completa
	
	

## Funcion para copiar una cfg a otra
func _copiar_cfg(origen: ConfigFile, destino: ConfigFile) -> void:
	for seccion in origen.get_sections():
		for clave in origen.get_section_keys(seccion):
			destino.set_value(seccion, clave, origen.get_value(seccion, clave))
