extends Control

func _ready() -> void:
	_rellenar_controles()

func _rellenar_controles() -> void:
	var _idioma = Configuracion.cfg_actual.get_value("juego","idioma","es")
	var _dificultad = Configuracion.cfg_actual.get_value("juego","dificultad",2)
	var _vol_musica = Configuracion.cfg_actual.get_value("audio","volumen_musica",100)
	var _vol_sfx = Configuracion.cfg_actual.get_value("audio","volumen_sfx",100)
	var _pantalla_completa = Configuracion.cfg_actual.get_value("video","pantalla_completa",false)
	for idioma in Configuracion.lista_idiomas_disponibles():
		print_debug("Idioma: %s" % idioma)
		$ColorRect/CenterContainer/VBoxContainer/HBoxContainer/select_idioma.add_item(idioma["nombre"], idioma["id"])
		if idioma["codigo"] == _idioma:			
			$ColorRect/CenterContainer/VBoxContainer/HBoxContainer/select_idioma.select(idioma["id"])
	$ColorRect/CenterContainer/VBoxContainer/HBoxContainer3/vol_musica.value = _vol_musica
	$ColorRect/CenterContainer/VBoxContainer/HBoxContainer4/vol_sfx.value = _vol_sfx
	$ColorRect/CenterContainer/VBoxContainer/HBoxContainer2/select_pantalla_completa.button_pressed = _pantalla_completa
	
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
	
func guardar() -> void:
	Configuracion.guardar_nueva_cfg()
	volver()

func volver() -> void:
	get_tree().change_scene_to_file("res://escenas/pantallas/pantalla_inicial.tscn")
