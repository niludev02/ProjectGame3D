extends Camera3D

@export var alvo: Node3D
@export var suavizacao_olhar := 4.0

var ponto_olhar: Vector3

func _ready() -> void:
	if alvo:
		ponto_olhar = alvo.global_position

func _physics_process(delta: float) -> void:
	if alvo == null:
		return

	# O ponto que a câmera olha se aproxima do personagem aos poucos
	var fator := 1.0 - exp(-suavizacao_olhar * delta)
	ponto_olhar = ponto_olhar.lerp(alvo.global_position, fator)

	look_at(ponto_olhar, Vector3.UP)
