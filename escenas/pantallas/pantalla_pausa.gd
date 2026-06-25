extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pausar_juego()

func pausar_juego() -> void:	
	EstadoJuego._pausar_reanudar_partida()
	visible = get_tree().paused

func _abrir_opciones() -> void:
	EstadoJuego.abrir_opciones("pantalla_pausa")
	visible = false
	get_parent().get_node("pantalla_opciones").visible = true
