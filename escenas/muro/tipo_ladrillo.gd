# tipo_ladrillo.gd
class_name TipoLadrillo extends Resource

@export var texturas: Array[Texture2D] = []  # [0]=intacto, [1]=roto, ...
@export var golpes: int = 2
