extends StaticBody2D

signal ladrillo_destruido(posicion: Vector2, extra: String)
signal ladrillo_golpeado

var golpes_restantes : int 
var _tipo : TipoLadrillo

@export var extra: String = ""

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
	ladrillo_golpeado.emit()
	if golpes_restantes <= 0:
		# todo: aumentar puntuacion por rotura
		ladrillo_destruido.emit(global_position, extra)
		queue_free()
	else:
		$Sprite2D.texture = _tipo.texturas[_tipo.golpes - golpes_restantes]
