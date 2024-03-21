extends Node2D

const SawScene = preload("res://saw_blade.tscn")

@onready var arrow_sprite_2d = $ArrowSprite2D
@onready var timer = $Timer

var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))

func _ready():
	arrow_sprite_2d.rotation = direction.angle() 
	timer.timeout.connect(_on_timer_timeout)
	Events.balloon_popped.connect(timer.stop)


func _process(delta):
	pass 

func _on_timer_timeout():
	Events.saw_blade_added.emit()
	var saw = SawScene.instantiate() # Se instancia la escena llamada en la constante
	saw.position = position # Se coloca la nueva escena en la posición de el sprite de esta escena
	saw.linear_velocity = direction * 50
	get_tree().current_scene.add_child(saw) # Se indica que se genera en la escena como escena hija
	queue_free()
