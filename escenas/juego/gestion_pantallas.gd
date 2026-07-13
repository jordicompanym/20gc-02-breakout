extends Control

@onready var juego = $".."

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		if juego.ubicacion == juego.Ubicaciones.JUGANDO || juego.ubicacion == juego.Ubicaciones.OPCIONES:
			juego._pausar_juego()
		elif juego.estado == juego.Estados.ACTIVO || juego.estado == juego.Estados.PERDIDAVIDA:
			juego._reanudar_partida()
