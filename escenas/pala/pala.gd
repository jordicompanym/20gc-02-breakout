extends CharacterBody2D

signal paleta_movimiento_inicial
var _en_juego : bool = false

@export var tecla_izquierda: String = "ui_left"
@export var tecla_derecha: String = "ui_right"
@export var velocidad: float = 600

func _ready() -> void:
	add_to_group("pala")

## posisonando la pala en la parte inferior de la pantalla
func posicion_inicial(screen_size : Vector2) -> void:
	position = Vector2((screen_size.x / 2) - ($ColorRect.size.x / 2), screen_size.y - 60)

func centro_pala() -> Vector2:
	return global_position + $ColorRect.size / 2.0

func _physics_process(delta):
	var dir := Input.get_axis(tecla_izquierda, tecla_derecha)
	if dir != 0 and not _en_juego:
			paleta_movimiento_inicial.emit()
			_en_juego = true

	velocity.x = dir * velocidad
	move_and_slide()
