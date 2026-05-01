extends Node

signal load_finished

var loading_screen : PackedScene = preload("uid://cqsf10t1k7svg")
var loaded_scene : PackedScene
var scene_path : String
var status : Array[bool]

func _ready() -> void:
	set_process(false)
	
func _process(_delta: float) -> void:
	var load_status : int = ResourceLoader.load_threaded_get_status(scene_path, status)
	match load_status :
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_scene = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(loaded_scene)
			load_finished.emit()
	
func load_scene(_scene_path : String) -> void :
	scene_path = _scene_path
	
	var load_screen : LoadingScreen = loading_screen.instantiate()
	add_child(load_screen)
	load_finished.connect(load_screen.on_load_finished)
	
	await load_screen.loading_screen_ready
	start_load()

func start_load() -> void:
	var state : int = ResourceLoader.load_threaded_request(scene_path, "", false)
	if state == OK:
		set_process(true)
