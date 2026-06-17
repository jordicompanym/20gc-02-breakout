extends Control

var _idiomas : Array
var _idioma_actual : String
var _vol_musica_actual : float
var _vol_sfx_actual : float
var _pantalla_completa_actual : bool
var _nuevo_idioma : String
var _nueva_dificultad : int
var _nuevo_vol_musica : float
var _nuevo_vol_sfx : float
var _nuevo_pantalla_completa : bool


func _ready() -> void:
	_recuperar_configuracion()
	_rellenar_controles()

func _recuperar_configuracion():
	## rellenar combo idiomas
	_idiomas = Gamestate.lista_idiomas_disponibles()
	_idioma_actual = Gamestate.idioma_cfg()
	_vol_musica_actual = Gamestate.volumen_musica_cfg()
	_vol_sfx_actual = Gamestate.volumen_sfx_cfg()
	_pantalla_completa_actual = Gamestate.pantalla_completa_cfg()
	
func _rellenar_controles():
	for idioma in _idiomas:
		print_debug(idioma)
		print_debug(_idioma_actual)
		$ColorRect/CenterContainer/VBoxContainer/HBoxContainer/select_idioma.add_item(idioma["nombre"], idioma["id"])
		if idioma["codigo"] == _idioma_actual:			
			$ColorRect/CenterContainer/VBoxContainer/HBoxContainer/select_idioma.select(idioma["id"])
	$ColorRect/CenterContainer/VBoxContainer/HBoxContainer3/vol_musica.value = _vol_musica_actual
	$ColorRect/CenterContainer/VBoxContainer/HBoxContainer4/vol_sfx.value = _vol_sfx_actual
	$ColorRect/CenterContainer/VBoxContainer/HBoxContainer2/select_pantalla_completa.button_pressed = _pantalla_completa_actual
	
func _cambiado_idioma(index : int):
	## guardar idioma seleccionado
	for idioma in _idiomas:
		var id = idioma["id"]
		if id == index:
			_nuevo_idioma = idioma["codigo"]

func _cambiada_vol_musica(nuevo : float):
	_nuevo_vol_musica = nuevo

func _cambiada_vol_sfx(nuevo : float):
	_nuevo_vol_sfx = nuevo

func _cambiada_pantalla_completa(nuevo : bool):
	_nuevo_pantalla_completa = nuevo

func guardar():
	var cfg = ConfigFile.new()
	cfg.set_value("juego", "idioma", _nuevo_idioma)
	cfg.set_value("juego", "dificultad", _nueva_dificultad)
	cfg.set_value("audio", "volumen_musica", _nuevo_vol_musica)
	cfg.set_value("audio", "volumen_sfx", _nuevo_vol_sfx)
	cfg.set_value("video", "pantalla_completa", _nuevo_pantalla_completa)
	cfg.save("user://configuracion.cfg")
	#TranslationServer.set_locale(_nuevo_idioma)
	volver()

func volver():
	get_tree().change_scene_to_file("res://escenas/pantallas/pantalla_inicial.tscn")
