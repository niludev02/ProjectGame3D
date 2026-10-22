extends CharacterBody3D

@export var vel_caminhada := 2.0
@export var vel_corrida := 4.5
@export var aceleracao := 12.0
@export var desaceleracao := 16.0
@export var vel_giro := 10.0

var gravidade: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
	# 1. GRAVIDADE
	if not is_on_floor():
		velocity.y -= gravidade * delta

	# 2. ENTRADA
	var entrada := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
	var direcao := Vector3(entrada.x, 0, entrada.y)

	# 3. VELOCIDADE ALVO
	var correr := Input.is_action_pressed("correr")
	var vel_max := vel_corrida if correr else vel_caminhada
	var alvo := Vector2(direcao.x, direcao.z) * vel_max

	# 4. ACELERAÇÃO
	var horizontal := Vector2(velocity.x, velocity.z)
	var taxa := aceleracao if direcao != Vector3.ZERO else desaceleracao
	horizontal = horizontal.move_toward(alvo, taxa * delta)
	velocity.x = horizontal.x
	velocity.z = horizontal.y

	# 5. ROTAÇÃO
	if direcao != Vector3.ZERO:
		var angulo_alvo := atan2(-direcao.x, -direcao.z)
		rotation.y = lerp_angle(rotation.y, angulo_alvo, vel_giro * delta)

	move_and_slide()
