extends RigidBody2D

const ANGULO_MAX := deg_to_rad(50.0)   # ángulo máximo de salida respecto a la horizontal
const PESO_PALA := 0.5                # cuánto influye la velocidad de la pala (0 = nada, 1 = mucho)

@export var speed: float = 600

var _detener_pelota: bool = false

func _ready() -> void:
	can_sleep = false
	contact_monitor = true       # habilita el reporte de contactos
	max_contacts_reported = 4    # cuántos contactos como máximo se reportan (0 por defecto, por eso "no hay nada")
	freeze = true
	
func posicion_inicial(posicion_pala : Vector2, dimension_pala : Vector2) -> void:
	# posicionando la pelota en el centro de la pantalla
	var dimensiones_textura : Vector2 = $Sprite2D.texture.get_size() * $Sprite2D.scale
	$Sprite2D.centered = true
	position = Vector2(posicion_pala.x + dimension_pala.x / 2, (posicion_pala.y - dimensiones_textura.y / 2) - 1)

func saque(screen_size : Vector2) -> void:
	var margin : float = 30.0
	var random_x : float = randf_range(margin, screen_size.x - margin)
	if freeze:
		freeze = false
		var direccion = (Vector2(random_x, screen_size.y / 2) - global_position).normalized()
		linear_velocity = direccion * speed

# Funcion de control del rebote con la pala
func _rebote_con_pala(state: PhysicsDirectBodyState2D, pala: CharacterBody2D, contacto: int) -> void:
	var centro_bola: Vector2 = state.transform.origin
	var centro_pala: Vector2 = pala.centro_pala()
	var mitad_ancho: float = pala.get_node("ColorRect").size.x / 2.0

	# 1. ¿dónde golpeó la pelota dentro del ancho de la pala? -1 borde izq, 0 centro, 1 borde dcho
	var offset_posicion: float = clampf((centro_bola.x - centro_pala.x) / mitad_ancho, -1.0, 1.0)

	# 2. inercia: ¿hacia dónde y con cuánta fuerza se movía la pala al golpear?
	var influencia_inercia: float = clampf(pala.velocity.x / pala.velocidad, -1.0, 1.0) * PESO_PALA

	# 3. combinar ambos efectos en un único ángulo respecto a la vertical
	var angulo: float = clampf(offset_posicion + influencia_inercia, -1.0, 1.0) * ANGULO_MAX

	# 4. nueva dirección: siempre hacia arriba, desviada lateralmente según el ángulo
	var nueva_direccion: Vector2 = Vector2(sin(angulo), -cos(angulo))
	state.linear_velocity = nueva_direccion * speed

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	# este es control por defecto para que la pelota no pierda velocidad.
	if state.linear_velocity.length() > 0:
		state.linear_velocity = state.linear_velocity.normalized() * speed

	# buscar los rebotes con la pala, si los hay, lanzar función de control del rebote con la pala
	for i in state.get_contact_count():
		var cuerpo = state.get_contact_collider_object(i)		
		if cuerpo.is_in_group("pala"):
			_rebote_con_pala(state, cuerpo, i)
	
	if _detener_pelota:
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		freeze = true
		_detener_pelota = false

func detener_pelota() -> void:
	_detener_pelota = true
	
