extends CharacterBody2D

signal paleta_en_posicion_inicial

var screen_size : Vector2
var _dimensiones_textura : Vector2
var _paleta_en_posicion_inicial : bool = true

@export var tecla_izquierda: String = "ui_left"
@export var tecla_derecha: String = "ui_right"
@export var velocidad: float = 900

func _ready() -> void:
	screen_size = get_viewport_rect().size
	add_to_group("pala")
	_dimensiones_textura = $Sprite2D.texture.get_size() * $Sprite2D.scale
	$Sprite2D.centered = true

## posisonando la pala en la parte inferior de la pantalla
func posicion_inicial() -> void:
	position = Vector2((screen_size.x / 2) - (_dimensiones_textura.x / 2), screen_size.y - 30)
	_paleta_en_posicion_inicial = true

func dimension_pala() -> Vector2:
	return _dimensiones_textura

func centro_pala() -> Vector2:
	return global_position + _dimensiones_textura / 2.0

func _physics_process(_delta):
	var dir := Input.get_axis(tecla_izquierda, tecla_derecha)
	if dir != 0 && _paleta_en_posicion_inicial == true:
		paleta_en_posicion_inicial.emit()
		_paleta_en_posicion_inicial == false
		
	velocity.x = dir * velocidad
	move_and_slide()
