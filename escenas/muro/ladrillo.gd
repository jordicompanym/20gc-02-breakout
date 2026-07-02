extends StaticBody2D

signal destruido(posicion: Vector2, extra: String)

var golpes_restantes : int 
var _tipo : TipoLadrillo

@export var extra: String = ""

func _ready() -> void:
	pass
func configurar(p_tipo: TipoLadrillo, dimensiones : Vector2) -> void:
	_tipo = p_tipo
	golpes_restantes = _tipo.golpes
	$Sprite2D.texture  = _tipo.texturas[0]
	$Sprite2D.scale    = dimensiones / Vector2(_tipo.texturas[0].get_size())
	$Sprite2D.position = dimensiones / 2.0          # centered=true → centrado en el ladrillo
	$CollisionShape2D.shape.size = dimensiones
	$CollisionShape2D.position   = dimensiones / 2.0
	add_to_group("ladrillos")

func recibir_golpe() -> void:      
	golpes_restantes -= 1
	EstadoJuego.aumentar_puntuacion(100)
	if golpes_restantes <= 0:
		EstadoJuego.aumentar_puntuacion(100)
		destruido.emit(global_position, extra)
		queue_free()
	else:
		$Sprite2D.texture = _tipo.texturas[_tipo.golpes - golpes_restantes]
