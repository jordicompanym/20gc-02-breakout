extends CharacterBody2D

signal paleta_movimiento_inicial
var screen_size : Vector2


@export var tecla_izquierda: String = "ui_left"
@export var tecla_derecha: String = "ui_right"
@export var velocidad: float = 600

func _ready() -> void:
	screen_size = get_viewport_rect().size
	add_to_group("pala")
	EstadoJuego.cambio_estado.connect(_on_cambio_estado)

func _on_cambio_estado(_nuevo_estado : EstadoJuego.Estado) -> void:
	if _nuevo_estado == EstadoJuego.Estado.PARADO:
		posicion_inicial()

## posisonando la pala en la parte inferior de la pantalla
func posicion_inicial() -> void:
	position = Vector2((screen_size.x / 2) - ($ColorRect.size.x / 2), screen_size.y - 60)

func centro_pala() -> Vector2:
	return global_position + $ColorRect.size / 2.0

func _physics_process(_delta):
	var dir := Input.get_axis(tecla_izquierda, tecla_derecha)
	if dir != 0 and EstadoJuego.estado == EstadoJuego.Estado.PARADO:
		paleta_movimiento_inicial.emit()

	velocity.x = dir * velocidad
	move_and_slide()
